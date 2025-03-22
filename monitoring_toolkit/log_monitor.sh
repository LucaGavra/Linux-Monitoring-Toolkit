#!/bin/bash

LOG_FILE="/var/log/syslog"  
ALERT_LOG="anomaly.log"

echo "Monitoring Logs for Errors..."
echo "---- Log Monitoring Started at $(date) ----" >> $ALERT_LOG

tail -n 100 -F $LOG_FILE | grep --line-buffered -i "error\|fail\|critical\|panic" | while read line
do
    echo "[$(date)] ALERT: $line"
    echo "[$(date)] ALERT: $line" >> $ALERT_LOG
done
