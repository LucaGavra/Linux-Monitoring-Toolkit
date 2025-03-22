#!/bin/bash
set -x  

while true; do
    SERVICES=("nginx" "mysql" "ssh")
    for SERVICE in "${SERVICES[@]}"
    do
        if /bin/systemctl list-units --type=service --all | /usr/bin/grep -q "$SERVICE.service"; then
            if ! /bin/systemctl is-active --quiet $SERVICE; then
                echo "Restarting $SERVICE..."
                /bin/systemctl restart $SERVICE
                echo "[$(date)] $SERVICE was down. Restarted." >> /home/luca/heal.log
            else
                echo "Service $SERVICE is already running."
            fi
        else
            echo "Service $SERVICE not found. Skipping..."
        fi
    done
    echo "Self-healing script completed. Sleeping for 60 seconds..."
    sleep 60
done

