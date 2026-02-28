# Task 3:  Monitor container resource usage and log CPU and memory usage with timestamps automatically  --using cronjob.

#  Objective

The objective of this task is to:

- Create a Bash script
- Schedule it using Cron
- Automatically log current date and time every 1 minute
- Follow proper Linux directory standards


#  Why We Created Folder Inside /opt ?

In Linux, the `/opt` directory is used for:

- Optional or custom applications
- Production-level scripts
- Third-party software

We created our monitoring project inside:

/opt/container-monitor

This keeps it:

- Separate from user home directories
- Organized
- Following Linux best practices
- Suitable for production environment

---

#  Directory Structure

/opt/container-monitor/
│
├── monitor.sh
└── logs/
    └── monitor.log

---

#  Implementation Steps

## Step 1: Create Monitoring Directory

sudo mkdir -p /opt/container-monitor/logs

---

## Step 2: Create Script File

sudo nano /opt/container-monitor/monitor.sh

Add the following content:

#!/bin/bash

# Log directory
LOG_DIR="/opt/container-monitor/logs"
LOG_FILE="$LOG_DIR/monitor.log"

# Create directory if not exists
mkdir -p $LOG_DIR

# Timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# CPU Usage (top command)
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')

# Memory Usage
MEMORY_USAGE=$(free -m | awk 'NR==2 {printf "%.2f%%", $3*100/$2 }')

# Write to log
echo "[$TIMESTAMP] CPU Usage: $CPU_USAGE | Memory Usage: $MEMORY_USAGE" >> $LOG_FILE
---

## Step 3: Make Script Executable

sudo chmod +x /opt/container-monitor/monitor.sh

---

## Step 4: Fix Ownership (Important)

Cron runs under ubuntu user.  
Since `/opt` is root-owned, we changed ownership:

sudo chown -R ubuntu:ubuntu /opt/container-monitor

This allows the script to write logs properly.

---

## Step 5: Add Cron Job

crontab -e

Add this line:

* * * * * /bin/bash /opt/container-monitor/monitor.sh

Verify:

crontab -l

---

## Step 6: Ensure Cron Service Is Running

sudo systemctl status cron
sudo systemctl start cron

---

#  Final Result

Every 1 minute:

- Script runs automatically
- Current date and time is saved in monitor.log

Check log using:

cat /opt/container-monitor/logs/monitor.log

Example Output:

[2026-02-27 19:10:01] CPU Usage: 12% | Memory Usage: 24.19%
[2026-02-27 19:11:01] CPU Usage: 4.8% | Memory Usage: 24.24%
[2026-02-27 19:11:07] CPU Usage: 4.8% | Memory Usage: 24.24%
[2026-02-27 19:12:01] CPU Usage: 4.8% | Memory Usage: 24.24%


---

#  Key Learnings

- Cron job scheduling
- Bash scripting basics
- Linux file permissions
- Ownership management
- Production directory structure (/opt)

---

# ✅ Task 3 Successfully Completed

Automated Date & Time Logging using Cron and Bash Script.
