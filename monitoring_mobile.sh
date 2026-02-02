#!/data/data/com.termux/files/usr/bin/bash

clear
echo "╔══════════════════════════════════════════════╗"
echo "║   MOBILE SYSTEM MONITOR - TERMUX            ║"
echo "║   [Monitoring e mobile e khodet]            ║"
echo "╚══════════════════════════════════════════════╝"
echo ""
echo "[1] MOBILE SPECIFIC INFORMATION"
echo "================================"

# 1. Android version (agar dastres bashad)
echo "[*] System Information:"
getprop ro.build.version.release 2>/dev/null && echo "Android Version: $(getprop ro.build.version.release)" || echo "Cannot get Android version"

# 2. Device model
getprop ro.product.model 2>/dev/null && echo "Device Model: $(getprop ro.product.model)" || echo "Model info not available"

# 3. CPU architecture
echo "CPU: $(uname -m)"
echo "Kernel: $(uname -r)"

# 4. Battery status
echo ""
echo "[*] Battery Info (if termux-api installed):"
termux-battery-status 2>/dev/null || echo "Install: pkg install termux-api"
echo ""
echo "[2] MOBILE RESOURCE USAGE"
echo "========================="

# 1. Memory usage on mobile
echo "[*] Memory Usage:"
free -h 2>/dev/null || cat /proc/meminfo | grep -E "MemTotal|MemFree|MemAvailable" | head -3

# 2. Storage monitoring
echo ""
echo "[*] Storage Space:"
df -h /data 2>/dev/null || echo "Checking internal storage..."
du -sh ~/ 2>/dev/null && echo "Termux home size: $(du -sh ~/ 2>/dev/null | cut -f1)"

# 3. CPU temperature (if accessible)
echo ""
echo "[*] CPU Temperature:"
cat /sys/class/thermal/thermal_zone*/temp 2>/dev/null | head -1 | awk '{print $1/1000 "°C"}' || echo "Temperature sensor not accessible"

echo ""
echo "[3] MOBILE NETWORK MONITOR"
echo "=========================="

# 1. Network type
echo "[*] Network Type:"
dumpsys telephony.registry 2>/dev/null | grep -E "mServiceState|mDataConnectionState" | head -2 || echo "Mobile network info requires Android permissions"

# 2. Signal strength
echo ""
echo "[*] Signal Strength (if termux-api):"
termux-telephony-cellinfo 2>/dev/null | grep -E "ci|signal" | head -3 || echo "Run: pkg install termux-api"

# 3. WiFi info
echo ""
echo "[*] WiFi Information:"
termux-wifi-connectioninfo 2>/dev/null || ip addr show wlan0 2>/dev/null | grep "inet" || echo "Not connected to WiFi"
echo ""
echo "[4] APP USAGE MONITOR"
echo "====================="

# 1. Termux app usage
echo "[*] Termux Package Usage:"
echo "Installed packages: $(pkg list-installed 2>/dev/null | wc -l)"
ls -la ~/ 2>/dev/null | grep -c "^-" | awk '{print "Files in home: "$1}'

# 2. Script usage
echo ""
echo "[*] Your Scripts:"
find ~/ -name "*.sh" -type f 2>/dev/null | head -5
echo "Total scripts: $(find ~/ -name "*.sh" -type f 2>/dev/null | wc -l)"

# 3. Project monitoring
echo ""
echo "[*] Your Projects:"
ls -la ~/ | grep -E "^d" | awk '{print $9}' | head -10
echo ""
echo "[5] MOBILE SECURITY CHECK"
echo "========================="

# 1. Check for suspicious files
echo "[*] Security Scan:"
echo "Checking for sensitive files..."
find ~/ -name "*.txt" -o -name "*.log" 2>/dev/null | grep -E "pass|secret|key|token|cred" | head -5

# 2. Check permissions
echo ""
echo "[*] File Permissions Check:"
ls -la ~/*.sh 2>/dev/null | head -5 | awk '{print $1 " " $9}'

# 3. Check for open ports on mobile
echo ""
echo "[*] Open Ports on YOUR Mobile:"
netstat -tulpn 2>/dev/null | grep LISTEN | head -5 || echo "No unusual open ports"
echo ""
echo "[6] MOBILE PERFORMANCE OPTIMIZER"
echo "================================"

# 1. Clean cache
echo "[*] Cache Cleaner:"
echo "Termux cache size: $(du -sh ~/.cache 2>/dev/null | cut -f1 2>/dev/null || echo '0B')"
echo ""
echo "[?] Clean Termux cache? (y/n): "
read clean_cache
if [ "$clean_cache" = "y" ]; then
    rm -rf ~/.cache/* 2>/dev/null
    echo "[+] Cache cleaned!"
fi

# 2. Remove old files
echo ""
echo "[*] Old Files Cleaner:"
echo "Files older than 30 days: $(find ~/ -type f -mtime +30 2>/dev/null | wc -l)"
echo ""
echo "[?] List old files? (y/n): "
read list_old
if [ "$list_old" = "y" ]; then
    find ~/ -type f -mtime +30 2>/dev/null | head -10
fi
echo ""
echo "[7] MOBILE BACKUP SYSTEM"
echo "========================"

backup_dir="$HOME/termux_backup_$(date +%Y%m%d)"

# Create backup
echo "[*] Creating backup of important files..."
mkdir -p "$backup_dir"
cp ~/*.sh "$backup_dir/" 2>/dev/null
cp -r ~/projects "$backup_dir/" 2>/dev/null
cp ~/.bashrc "$backup_dir/" 2>/dev/null 2>/dev/null

echo "[+] Backup created at: $backup_dir"
echo "Backup size: $(du -sh "$backup_dir" 2>/dev/null | cut -f1)"

# Backup packages list
echo ""
echo "[*] Backing up package list..."
pkg list-installed > "$backup_dir/installed_packages.txt" 2>/dev/null
echo "[+] Package list saved"
echo ""
echo "[8] LEARNING PROGRESS MONITOR"
echo "=============================="

# Track your learning progress
progress_file="$HOME/learning_progress.txt"

echo "[*] Your Learning Progress:"
if [ -f "$progress_file" ]; then
    echo "Scripts created: $(grep -c "Created script" "$progress_file")"
    echo "Last activity: $(tail -1 "$progress_file")"
else
    echo "No progress file found. Creating..."
    echo "$(date): Started monitoring" > "$progress_file"
fi

echo ""
echo "[?] Add today's achievement: "
read achievement
if [ -n "$achievement" ]; then
    echo "$(date): $achievement" >> "$progress_file"
    echo "[+] Progress saved!"
fi
echo ""
echo "[9] MOBILE AUTOMATION TOOLS"
echo "==========================="

# Create automation script
auto_script="$HOME/mobile_automation.sh"

cat > "$auto_script" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash

# Mobile automation script
echo "=== MOBILE AUTOMATION ==="
echo "1. Daily backup"
echo "2. Clean system"
echo "3. Update packages"
echo "4. Check security"
echo ""
echo "[?] Choose action: "
read action

case $action in
    1)
        # Daily backup
        backup_dir="$HOME/backup_$(date +%Y%m%d)"
        mkdir -p "$backup_dir"
        cp ~/*.sh "$backup_dir/" 2>/dev/null
        echo "[+] Backup created"
        ;;
    2)
        # Clean system
        rm -rf ~/.cache/*
        find ~/ -name "*.tmp" -delete 2>/dev/null
        echo "[+] System cleaned"
        ;;
    3)
        # Update packages
        pkg update && pkg upgrade -y
        echo "[+] Packages updated"
        ;;
    4)
        # Security check
        echo "[*] Checking file permissions..."
        find ~/ -name "*.sh" -exec ls -la {} \; 2>/dev/null | head -10
        echo "[*] Checking open ports..."
        netstat -tulpn 2>/dev/null | grep LISTEN
        ;;
    *)
        echo "Invalid option"
        ;;
esac
EOF

chmod +x "$auto_script"
echo "[+] Automation script created: $auto_script"
echo ""
echo "[10] RESOURCE ALERT SYSTEM"
echo "=========================="

alert_script="$HOME/resource_alert.sh"

cat > "$alert_script" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash

# Resource alert system for mobile
ALERT_FILE="$HOME/resource_alerts.log"

# Check disk space
disk_usage=$(df /data 2>/dev/null | tail -1 | awk '{print $5}' | sed 's/%//')
if [ -n "$disk_usage" ] && [ "$disk_usage" -gt 80 ]; then
    echo "[ALERT] High disk usage: ${disk_usage}%" | tee -a "$ALERT_FILE"
fi

# Check memory
mem_free=$(free -m 2>/dev/null | grep Mem | awk '{print $4}')
if [ -n "$mem_free" ] && [ "$mem_free" -lt 100 ]; then
    echo "[ALERT] Low memory: ${mem_free}MB free" | tee -a "$ALERT_FILE"
fi

# Check battery if termux-api installed
battery=$(termux-battery-status 2>/dev/null | grep percentage | cut -d: -f2 | tr -d ' ,')
if [ -n "$battery" ] && [ "$battery" -lt 20 ]; then
    echo "[ALERT] Low battery: ${battery}%" | tee -a "$ALERT_FILE"
fi

# Show recent alerts
echo ""
echo "[*] Recent alerts:"
tail -5 "$ALERT_FILE" 2>/dev/null || echo "No alerts yet"
EOF

chmod +x "$alert_script"
echo "[+] Alert system created: $alert_alert.sh"
echo "[*] Run daily to check resources"
echo ""
echo "[11] MOBILE PROJECT MANAGER"
echo "==========================="

project_tracker="$HOME/projects/project_tracker.txt"

echo "[*] Your Projects Status:"
if [ -f "$project_tracker" ]; then
    echo "Active projects: $(grep -c "STATUS:ACTIVE" "$project_tracker")"
    echo "Completed projects: $(grep -c "STATUS:DONE" "$project_tracker")"
    echo ""
    echo "Recent projects:"
    tail -5 "$project_tracker"
else
    echo "No project tracker found."
    echo "Creating sample project..."
    mkdir -p "$HOME/projects"
    echo "$(date): STATUS:ACTIVE | PROJECT:Termux Monitor | DESC:Creating monitoring tools" > "$project_tracker"
    echo "$(date): STATUS:DONE | PROJECT:Password Generator | DESC:Completed password tool" >> "$project_tracker"
fi

echo ""
echo "[?] Add new project? (y/n): "
read add_project
if [ "$add_project" = "y" ]; then
    echo "[?] Project name: "
    read proj_name
    echo "[?] Project description: "
    read proj_desc
    echo "$(date): STATUS:ACTIVE | PROJECT:$proj_name | DESC:$proj_desc" >> "$project_tracker"
    echo "[+] Project added!"
fi

