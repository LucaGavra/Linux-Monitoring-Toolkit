

echo "System Monitoring Script"
echo "------------------------"

while true; do  # Infinite loop to keep monitoring system continuously
    echo "Time: $(date)"  # Print current time
    echo "CPU Load: $(uptime | awk '{print $8, $9, $10}')"  # Extract CPU load from uptime
    echo "Memory Usage: $(free -h | grep Mem | awk '{print $3 "/" $2}')"  # Get used/total memory
    echo "Disk Usage: $(df -h | grep '/$' | awk '{print $5}')"  # Get root ("/") disk usage
    echo "Network Activity: $(ifstat 1 1 | awk 'NR==3 {print $1 " KB/s in, " $2 " KB/s out"}')"  # Network usage
    echo "------------------------"
    sleep 5  # Wait 5 seconds before checking again
done
