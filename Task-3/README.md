# Task 3: Monitor Container Resource Usage and Log CPU/Memory with Timestamps (Cron Job)

## Objective

In this task, we will:

- Create a Bash script to capture CPU and memory usage
- Schedule it using `cron`
- Log usage data **every 1 minute** with **current date and time**
- Follow proper Linux directory standards

---

## Why Create a Folder Inside `/opt`?

In Linux, the `/opt` directory is typically used for:

- Optional or custom applications
- Third‑party software
- Production-level scripts/tools not managed by the system package manager

We place this monitoring project inside:

`/opt/container-monitor`

This keeps it:

- Separated from user home directories
- Organized and easy to maintain
- Aligned with Linux best practices
- Suitable for a production environment

---

## Directory Structure

```text
/opt/container-monitor/
├── monitor.sh
└── logs/
    └── monitor.log
```

---

## Implementation Steps

### Step 1: Create the Monitoring Directory

```bash
sudo mkdir -p /opt/container-monitor/logs
```

---

### Step 2: Create the Script File

Create and open the script:

```bash
sudo nano /opt/container-monitor/monitor.sh
```

Paste the following content:

```bash
#!/bin/bash

# Log directory and file
LOG_DIR="/opt/container-monitor/logs"
LOG_FILE="$LOG_DIR/monitor.log"

# Ensure log directory exists
mkdir -p "$LOG_DIR"

# Timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# CPU Usage (%): calculate non-idle from top output
CPU_USAGE=$(top -bn1 | awk -F',' '/Cpu\(s\)/ {gsub(/.*id, /,"",$4); gsub(/ .*/,"",$4); printf "%.1f%%", 100 - $4}')

# Memory Usage (%)
MEMORY_USAGE=$(free -m | awk 'NR==2 {printf "%.2f%%", $3*100/$2}')

# Append to log
echo "[$TIMESTAMP] CPU Usage: $CPU_USAGE | Memory Usage: $MEMORY_USAGE" >> "$LOG_FILE"
```

---

### Step 3: Make the Script Executable

```bash
sudo chmod +x /opt/container-monitor/monitor.sh
```

---

### Step 4: Fix Ownership (Important)

If the cron job runs under the `ubuntu` user and `/opt` is root-owned, the script may fail to write logs.

Fix ownership:

```bash
sudo chown -R ubuntu:ubuntu /opt/container-monitor
```

(Adjust the username if your system user is different.)

---

### Step 5: Add the Cron Job

Edit the current user’s crontab:

```bash
crontab -e
```

Add this line to run every minute:

```cron
* * * * * /bin/bash /opt/container-monitor/monitor.sh
```

Verify the cron entry:

```bash
crontab -l
```

---

### Step 6: Ensure the Cron Service Is Running

```bash
sudo systemctl status cron
sudo systemctl start cron
```

---

## Final Result

Every 1 minute:

- The script runs automatically
- CPU usage and memory usage are logged with a timestamp in `monitor.log`

Check the log file:

```bash
cat /opt/container-monitor/logs/monitor.log
```

Example output:

```text
[2026-02-27 19:10:01] CPU Usage: 12.0% | Memory Usage: 24.19%
[2026-02-27 19:11:01] CPU Usage: 4.8%  | Memory Usage: 24.24%
[2026-02-27 19:12:01] CPU Usage: 5.1%  | Memory Usage: 24.24%
```

---

## Key Learnings

- Cron job scheduling
- Bash scripting basics
- Linux permissions and ownership
- Organizing scripts under `/opt` for production-style setups

---

## ✅ Task 3 Completed

Automated CPU & Memory logging with timestamps using a Bash script and Cron.
