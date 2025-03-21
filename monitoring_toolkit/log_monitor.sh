#!/bin/bash

# Define log file path
LOG_FILE="/var/log/syslog"  # Change to /var/log/messages on RHEL-based systems
ALERT_LOG="anomaly.log"

echo "Monitoring Logs for Errors..."
echo "---- Log Monitoring Started at $(date) ----" >> $ALERT_LOG

# Monitor logs for errors in real-time
tail -n 100 -F $LOG_FILE | grep --line-buffered -i "error\|fail\|critical\|panic" | while read line
do
    echo "[$(date)] ALERT: $line"
    echo "[$(date)] ALERT: $line" >> $ALERT_LOG
done
