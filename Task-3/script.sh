#!/bin/bash

LOG_FILE="/opt/container-monitor/logs/monitor.log"

echo "===== System Monitoring: $(date) =====" >> $LOG_FILE

# CPU Usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
echo "CPU Usage: $CPU_USAGE %" >> $LOG_FILE

# Memory Usage
MEMORY_USAGE=$(free -m | awk 'NR==2{printf "%.2f", $3*100/$2 }')
echo "Memory Usage: $MEMORY_USAGE %" >> $LOG_FILE

echo "---------------------------------------" >> $LOG_FILE
echo "" >> $LOG_FILE
