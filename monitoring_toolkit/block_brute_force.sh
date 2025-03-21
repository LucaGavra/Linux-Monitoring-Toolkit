#!/bin/bash

LOG_FILE="/var/log/auth.log"  # Change to /var/log/secure on RHEL-based systems
THRESHOLD=5  # Number of failed attempts before blocking
BAN_DURATION="3600"  # Ban duration in seconds (1 hour)

# Find IPs with multiple failed login attempts
FAILED_IPS=$(grep "Failed password" $LOG_FILE | awk '{print $(NF-3)}' | sort | uniq -c | awk -v threshold=$THRESHOLD '$1 > threshold {print $2}')

for IP in $FAILED_IPS
do
    # Check if IP is already blocked
    if ! iptables -L INPUT -n | grep -q "$IP"; then
        echo "Blocking IP: $IP"
        iptables -A INPUT -s $IP -j DROP
        echo "[$(date)] Blocked SSH brute-force attacker: $IP" >> security.log

        # Automatically remove the ban after BAN_DURATION seconds
        (sleep $BAN_DURATION; iptables -D INPUT -s $IP -j DROP; echo "[$(date)] Unblocked: $IP" >> security.log) &
    fi
done
