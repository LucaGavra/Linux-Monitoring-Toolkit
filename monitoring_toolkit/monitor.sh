

echo "System Monitoring Script"
echo "------------------------"

while true; do  
    echo "Time: $(date)"  
    echo "CPU Load: $(uptime | awk '{print $8, $9, $10}')"  
    echo "Memory Usage: $(free -h | grep Mem | awk '{print $3 "/" $2}')"  
    echo "Disk Usage: $(df -h | grep '/$' | awk '{print $5}')"  
    echo "Network Activity: $(ifstat 1 1 | awk 'NR==3 {print $1 " KB/s in, " $2 " KB/s out"}')"  
    echo "------------------------"
    sleep 5  
done
