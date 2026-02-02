#!/data/data/com.termux/files/usr/bin/bash

# Barname e System Monitor ba capability haye poshesh
# Ba estefade az command haye dakhel e system

clear
echo "╔══════════════════════════════════════════════════════════╗"
echo "║    SYSTEM ACTIVITY MONITOR - TERMUX                     ║"
echo "║    [Peigiri e gheir-e mahramane]                        ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
echo "[1] FILE SYSTEM MONITOR"
echo "========================"

# 1. Monitor file haye jadid dar home directory
echo "[*] File haye jadid dar ~/ :"
find ~/ -type f -mmin -60 2>/dev/null | head -10

# 2. Monitor directory haye active
echo ""
echo "[*] Directory haye ke akharin bar estefade shode:"
ls -lt ~/ | head -5

# 3. Large files
echo ""
echo "[*] File haye bozorg (>10MB):"
find ~/ -type f -size +10M 2>/dev/null | head -5

# 4. Hidden files
echo ""
echo "[*] Hidden files dar home:"
find ~/ -type f -name ".*" 2>/dev/null | head -10
echo ""
echo "[2] PROCESS MONITOR"
echo "==================="

# 1. Tamam process haye system
echo "[*] Top 10 Process haye system:"
ps aux --sort=-%cpu | head -10

# 2. Process haye Termux
echo ""
echo "[*] Process haye Termux:"
ps -ef | grep -E "termux|bash|sh" | grep -v grep

# 3. Network processes
echo ""
echo "[*] Process haye network:"
netstat -tulpn 2>/dev/null | head -10 || ss -tulpn 2>/dev/null | head -10

# 4. Background jobs
echo ""
echo "[*] Background jobs:"
jobs -l
echo ""
echo "[3] NETWORK MONITOR"
echo "==================="

# 1. Active connections
echo "[*] Connection haye active:"
netstat -an | grep ESTABLISHED 2>/dev/null || ss -t state established 2>/dev/null

# 2. Open ports
echo ""
echo "[*] Port haye baz:"
netstat -tulpn 2>/dev/null || ss -tulpn 2>/dev/null

# 3. Traffic monitoring
echo ""
echo "[*] Network interfaces:"
ip addr show 2>/dev/null || ifconfig 2>/dev/null

# 4. DNS queries (log files)
echo ""
echo "[*] DNS cache/resolv:"
cat /etc/resolv.conf 2>/dev/null | grep nameserver
echo ""
echo "[4] SYSTEM LOGS MONITOR"
echo "======================="

# 1. Last login
echo "[*] Last login history:"
lastlog 2>/dev/null || echo "Not available"

# 2. Current logged in users
echo ""
echo "[*] Logged in users:"
who

# 3. Command history analysis
echo ""
echo "[*] Common commands used:"
echo "Most used commands (if history available):"
tail -50 ~/.bash_history 2>/dev/null | sort | uniq -c | sort -rn | head -10

# 4. Package installations
echo ""
echo "[*] Akharin package haye nasb shode:"
grep "install" /data/data/com.termux/files/usr/var/log/apt/history.log 2>/dev/null | tail -5 || echo "Log not found"
echo ""
echo "[5] APPLICATION MONITOR"
echo "======================="

# 1. Termux packages
echo "[*] Installed packages count:"
pkg list-installed 2>/dev/null | wc -l

# 2. Python packages
echo ""
echo "[*] Python packages:"
pip list 2>/dev/null | head -10 || echo "Python not installed"

# 3. Node.js packages
echo ""
echo "[*] Node.js packages:"
npm list -g --depth=0 2>/dev/null | head -10 || echo "Node.js not installed"

# 4. Git repositories
echo ""
echo "[*] Git repositories in home:"
find ~/ -name ".git" -type d 2>/dev/null | head -5
echo ""
echo "[6] REAL-TIME MONITORING"
echo "========================"

# Function for real-time monitoring
realtime_monitor() {
    echo "[*] Real-time monitoring (Ctrl+C to stop)"
    echo "Press any key to continue..."
    read -n 1 -s
    
    # Real-time process monitoring
    echo ""
    echo "[Live Process Monitor]:"
    top -b -n 1 | head -20
    
    echo ""
    echo "[Live Disk Usage]:"
    df -h /data 2>/dev/null
    
    echo ""
    echo "[Live Memory Usage]:"
    free -h 2>/dev/null
}

# Ask for real-time monitoring
echo "[?] Show real-time monitoring? (y/n): "
read show_realtime

if [ "$show_realtime" = "y" ] || [ "$show_realtime" = "Y" ]; then
    realtime_monitor
fi
echo ""
echo "[7] AUTOMATED MONITOR SCRIPT"
echo "============================="

# Create automated monitor script
monitor_script="$HOME/auto_monitor.sh"

cat > "$monitor_script" << 'EOF'
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
EOF

chmod +x "$monitor_script"
echo "[+] Auto monitor script created: $monitor_script"
echo "[*] Run it with: ./auto_monitor.sh"
echo "[*] Check logs at: $HOME/system_monitor.log"

# Create cron job suggestion
echo ""
echo "[*] For automated monitoring, add to crontab:"
echo "    crontab -e"
echo "    Add: */30 * * * * $HOME/auto_monitor.sh"
echo ""
echo "[8] STEALTH MONITORING TOOLS"
echo "============================="

# 1. Keylogger simulation (educational only)
echo "[!] EDUCATIONAL - KEYLOG SIMULATION"
echo "The following shows input methods, NOT actual keylogging"

# 2. Screenshot capability check
echo ""
echo "[*] Screenshot capabilities:"
echo "Termux doesn't have direct screenshot access"
echo "But can check if screenshot apps are installed:"
pm list packages | grep -i screen 2>/dev/null | head -5 || echo "No package manager access"

# 3. Clipboard monitoring
echo ""
echo "[*] Clipboard access check:"
echo "Termux can access clipboard via termux-clipboard"
echo "Install: pkg install termux-api"
echo "Then: termux-clipboard-get"

# 4. Notification monitoring
echo ""
echo "[*] Notification monitoring:"
echo "Requires termux-api package"
echo "Command: termux-notification-list"
echo ""
echo "[9] ADVANCED MONITOR SCRIPT"
echo "============================"

# Advanced monitoring script
adv_script="$HOME/adv_monitor.sh"

cat > "$adv_script" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash

# Advanced monitoring with stealth features
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
LOG_DIR="$HOME/.monitor_logs"
mkdir -p "$LOG_DIR"

LOG_FILE="$LOG_DIR/monitor_$TIMESTAMP.log"

# Stealth mode - minimal output
stealth_mode() {
    echo "[S] $(date)" > "$LOG_FILE"
    
    # Check active SSH sessions
    echo "[S] SSH sessions:" >> "$LOG_FILE"
    who | grep -E "pts|ssh" >> "$LOG_FILE" 2>/dev/null
    
    # Check for remote connections
    echo "[S] Remote IPs:" >> "$LOG_FILE"
    netstat -an 2>/dev/null | grep -E ":22|:443|:80" | grep ESTAB >> "$LOG_FILE"
    
    # Check for large data transfers
    echo "[S] Large files modified:" >> "$LOG_FILE"
    find ~/ -type f -size +5M -mmin -120 2>/dev/null | head -5 >> "$LOG_FILE"
    
    # Check for suspicious processes
    echo "[S] Suspicious processes:" >> "$LOG_FILE"
    ps aux 2>/dev/null | grep -E "nmap|metasploit|hydra|sqlmap|aircrack" >> "$LOG_FILE"
}

# Quick check mode
quick_check() {
    echo "[Q] Quick System Check - $(date)"
    echo "Memory: $(free -h 2>/dev/null | grep Mem | awk '{print $3 "/" $2}')"
    echo "Disk: $(df -h /data 2>/dev/null | tail -1 | awk '{print $5}') used"
    echo "Users: $(who | wc -l)"
    echo "Processes: $(ps aux | wc -l)"
}

# Network sniff mode (limited)
network_sniff() {
    echo "[N] Network Sniff - $(date)"
    echo "Active connections count: $(netstat -an 2>/dev/null | grep ESTABLISHED | wc -l)"
    echo "Listening ports: $(netstat -tulpn 2>/dev/null | wc -l)"
    
    # Top talking IPs (if root)
    echo "Top IPs:"
    netstat -an 2>/dev/null | grep ESTABLISHED | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -rn | head -5
}

# Main menu
case "$1" in
    "stealth")
        stealth_mode
        echo "Log saved to: $LOG_FILE"
        ;;
    "quick")
        quick_check
        ;;
    "network")
        network_sniff
        ;;
    *)
        echo "Usage: $0 [stealth|quick|network]"
        ;;
esac
EOF

chmod +x "$adv_script"
echo "[+] Advanced monitor created: $adv_script"
echo "[*] Modes: ./adv_monitor.sh stealth|quick|network"
echo ""
echo "[10] CLEANUP & ANTI-DETECTION"
echo "=============================="

# Cleanup script
cleanup_script="$HOME/clean_trace.sh"

cat > "$cleanup_script" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash

# Clean traces script
echo "[*] Cleaning system traces..."

# 1. Clear bash history
if [ -f ~/.bash_history ]; then
    echo "[+] Clearing bash history..."
    > ~/.bash_history
fi

# 2. Clear command history
echo "[+] Clearing command history..."
history -c

# 3. Remove temporary files
echo "[+] Removing temp files..."
rm -rf /tmp/*
rm -rf ~/.cache/*

# 4. Clear logs (if accessible)
echo "[+] Clearing log files..."
find ~/ -name "*.log" -type f -delete 2>/dev/null

# 5. Remove monitor logs
echo "[+] Removing monitor logs..."
rm -rf ~/.monitor_logs 2>/dev/null
rm -f ~/system_monitor.log 2>/dev/null

# 6. Clear download cache
echo "[+] Clearing download cache..."
rm -rf ~/storage/downloads/* 2>/dev/null

# 7. Reset file permissions
echo "[+] Resetting permissions..."
chmod 700 ~/*.sh 2>/dev/null

echo "[*] Cleanup complete!"
echo "[!] Note: Some system logs may require root access to clear"
EOF

chmod +x "$cleanup_script"
echo "[+] Cleanup script created: $cleanup_script"
echo "[*] Run with: ./clean_trace.sh"

# Final warnings
echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║                    IMPORTANT NOTES                       ║"
echo "╠══════════════════════════════════════════════════════════╣"
echo "║ 1. These tools are for EDUCATIONAL PURPOSES only        ║"
echo "║ 2. Always respect privacy laws                           ║"
echo "║ 3. Monitoring without consent may be illegal             ║"
echo "║ 4. Use responsibly and ethically                         ║"
echo "║ 5. This is SYSTEM monitoring, NOT personal monitoring    ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""
echo "[11] LEGAL ALTERNATIVE - SELF MONITORING"
echo "========================================"

# Self-monitoring script
self_monitor="$HOME/self_check.sh"

cat > "$self_monitor" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash

# Legal self-monitoring tool
echo "╔══════════════════════════════════════════════════════════╗"
echo "║                SELF SYSTEM CHECK                         ║"
echo "║         (100% Legal & Ethical)                           ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo ""

# Check your own system security
echo "[1] MY SYSTEM SECURITY CHECK"
echo "============================"
echo "[*] Open ports on MY device:"
netstat -tulpn 2>/dev/null || ss -tulpn 2>/dev/null

echo ""
echo "[*] Active connections from MY device:"
netstat -an 2>/dev/null | grep ESTABLISHED

echo ""
echo "[*] Processes running under MY user:"
ps -u $(whoami)

echo ""
echo "[2] MY PRIVACY CHECK"
echo "===================="
echo "[*] Files modified by ME recently:"
find ~/ -type f -mmin -60 -user $(whoami) 2>/dev/null | head -10

echo ""
echo "[*] MY command history summary:"
tail -20 ~/.bash_history 2>/dev/null | awk '{print $1}' | sort | uniq -c | sort -rn

echo ""
echo "[3] MY RESOURCE USAGE"
echo "====================="
echo "[*] MY memory usage:"
free -h 2>/dev/null | grep -E "Mem:|Total"

echo ""
echo "[*] MY disk usage:"
df -h /data 2>/dev/null

echo ""
echo "╔══════════════════════════════════════════════════════════╗"
echo "║   This tool helps YOU monitor YOUR own system           ║"
echo "║   Protecting YOUR privacy and security                  ║"
echo "╚══════════════════════════════════════════════════════════╝"
EOF

chmod +x "$self_monitor"
echo "[+] Self-monitoring tool created: $self_monitor"
echo "[*] Monitor YOUR own system: ./self_check.sh"
echo "aidin... "
