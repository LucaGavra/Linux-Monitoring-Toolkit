#!/bin/bash

DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$DISK_USAGE" -gt 90 ]; then
    echo "Disk usage critical ($DISK_USAGE%). Cleaning logs..."
    rm -rf /var/log/*.log
    echo "[$(date)] Logs cleaned due to high disk usage." >> heal.log
fi
