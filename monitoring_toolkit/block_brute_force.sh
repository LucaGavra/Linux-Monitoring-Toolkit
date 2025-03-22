#!/bin/bash

LOG_FILE="/var/log/auth.log"  
THRESHOLD=5  
BAN_DURATION="3600"  

FAILED_IPS=$(grep "Failed password" $LOG_FILE | awk '{print $(NF-3)}' | sort | uniq -c | awk -v threshold=$THRESHOLD '$1 > threshold {print $2}')

for IP in $FAILED_IPS
do
    if ! iptables -L INPUT -n | grep -q "$IP"; then
        echo "Blocking IP: $IP"
        iptables -A INPUT -s $IP -j DROP
        echo "[$(date)] Blocked SSH brute-force attacker: $IP" >> security.log

        (sleep $BAN_DURATION; iptables -D INPUT -s $IP -j DROP; echo "[$(date)] Unblocked: $IP" >> security.log) &
    fi
done
