#!/data/data/com.termux/files/usr/bin/bash

# Auto monitoring script
LOG_FILE="$HOME/system_monitor.log"

echo "=== SYSTEM MONITOR - $(date) ===" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# 1. Users
echo "Logged in users:" >> "$LOG_FILE"
who >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# 2. Active processes
echo "Top 5 processes:" >> "$LOG_FILE"
ps aux --sort=-%cpu | head -5 >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# 3. Network connections
echo "Active connections:" >> "$LOG_FILE"
netstat -an 2>/dev/null | grep ESTABLISHED | head -5 >> "$LOG_FILE" || echo "No network info" >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# 4. Disk usage
echo "Disk usage:" >> "$LOG_FILE"
df -h /data 2>/dev/null >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

# 5. New files
echo "New files (last 30 min):" >> "$LOG_FILE"
find ~/ -type f -mmin -30 2>/dev/null | head -10 >> "$LOG_FILE"
echo "" >> "$LOG_FILE"

echo "=== END LOG ===" >> "$LOG_FILE"
