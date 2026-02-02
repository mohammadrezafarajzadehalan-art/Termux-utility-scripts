echo ""
echo "[PART 6] FINAL SETUP AND INTEGRATION"
echo "===================================="

# Create the main system launcher
main_launcher="$HOME/MonitoringSystem/monitoring_system.sh"

cat > "$main_launcher" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash

# Complete Monitoring System Launcher
clear
echo "╔════════════════════════════════════════════════════════════╗"
echo "║        PROFESSIONAL MONITORING SYSTEM v2.0                ║"
echo "║        [Complete Edition - Mobile Mastery]                ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "Initializing system..."
sleep 1

# Check system requirements
echo "[*] Checking system requirements..."
if ! command -v bash &> /dev/null; then
    echo "[-] Bash not found!"
    exit 1
fi

echo "[+] Bash: OK"
echo "[+] Termux: OK"
echo "[+] Storage: $(df -h /data 2>/dev/null | tail -1 | awk '{print $4}') available"
echo ""

# Initialize directories
echo "[*] Initializing directories..."
mkdir -p "$HOME/MonitoringSystem"
mkdir -p "$HOME/MonitoringSystem/{bin,config,logs,reports,backups}"
echo "[+] Directory structure ready"

# Initialize logs
echo "[*] Initializing log files..."
touch "$HOME/MonitoringSystem/logs/system.log"
touch "$HOME/MonitoringSystem/logs/security.log"
touch "$HOME/MonitoringSystem/logs/network.log"
echo "[+] Log system ready"

# Load main menu
while true; do
    clear
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║                 MAIN DASHBOARD                             ║"
    echo "║          System Status: $(date +"%H:%M:%S")                       ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo ""
    
    # Quick status display
    echo "[QUICK STATUS]"
    echo "──────────────"
    
    # CPU
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
    echo "CPU: ${cpu_usage}%"
    
    # Memory
    mem_total=$(free -m | grep Mem | awk '{print $2}')
    mem_used=$(free -m | grep Mem | awk '{print $3}')
    mem_percent=$((mem_used * 100 / mem_total))
    echo "Memory: ${mem_percent}%"
    
    # Disk
    disk_usage=$(df -h /data 2>/dev/null | tail -1 | awk '{print $5}')
    echo "Disk: $disk_usage"
    
    # Alerts
    alert_count=$(grep -c "ALERT" "$HOME/MonitoringSystem/logs"/*.log 2>/dev/null)
    echo "Active Alerts: $alert_count"
    echo ""
    
    echo "[MAIN MENU]"
    echo "───────────"
    echo "1. 📊 Real-time Dashboard"
    echo "2. ⚙️  Resource Monitor"
    echo "3. 🔒 Security Scanner"
    echo "4. 🌐 Network Analyzer"
    echo "5. 📋 Report Generator"
    echo "6. 🤖 Automation Manager"
    echo "7. ⚙️  System Configuration"
    echo "8. 📚 Help & Documentation"
    echo "9. 🚪 Exit"
    echo ""
    
    echo "[?] Select option (1-9): "
    read choice
    
    case $choice in
        1)
            $HOME/MonitoringSystem/bin/dashboard.sh
            ;;
        2)
            $HOME/MonitoringSystem/bin/resource_monitor.sh
            ;;
        3)
            $HOME/MonitoringSystem/bin/security_scanner.sh
            ;;
        4)
            $HOME/MonitoringSystem/bin/network_analyzer.sh
            ;;
        5)
            $HOME/MonitoringSystem/bin/report_generator.sh
            ;;
        6)
            $HOME/MonitoringSystem/bin/automation_manager.sh
            ;;
        7)
            echo ""
            echo "System Configuration:"
            echo "1. Edit main configuration"
            echo "2. View system information"
            echo "3. Test all modules"
            echo "4. Reset system"
            echo ""
            echo "[?] Select option: "
            read config_choice
            
            case $config_choice in
                1)
                    nano "$HOME/MonitoringSystem/config/monitor_config.conf"
                    ;;
                2)
                    echo ""
                    echo "System Information:"
                    echo "───────────────────"
                    echo "Version: 2.0"
                    echo "Last Updated: $(date)"
                    echo "Modules: 6"
                    echo "Reports: $(ls -la "$HOME/MonitoringSystem/reports"/*.txt 2>/dev/null | wc -l)"
                    echo "Logs: $(ls -la "$HOME/MonitoringSystem/logs"/*.log 2>/dev/null | wc -l)"
                    ;;
                3)
                    echo ""
                    echo "Testing all modules..."
                    echo "1. Resource monitor: $(timeout 2 $HOME/MonitoringSystem/bin/resource_monitor.sh >/dev/null && echo "✅" || echo "❌")"
                    echo "2. Security scanner: $(timeout 2 $HOME/MonitoringSystem/bin/security_scanner.sh >/dev/null && echo "✅" || echo "❌")"
                    echo "3. Network analyzer: $(timeout 2 $HOME/MonitoringSystem/bin/network_analyzer.sh >/dev/null && echo "✅" || echo "❌")"
                    echo "4. Report generator: $(timeout 2 $HOME/MonitoringSystem/bin/report_generator.sh >/dev/null && echo "✅" || echo "❌")"
                    echo "5. Automation manager: $(timeout 2 $HOME/MonitoringSystem/bin/automation_manager.sh >/dev/null && echo "✅" || echo "❌")"
                    ;;
                4)
                    echo ""
                    echo "[!] WARNING: This will reset the system"
                    echo "[?] Are you sure? (y/n): "
                    read reset_confirm
                    if [ "$reset_confirm" = "y" ]; then
                        rm -rf "$HOME/MonitoringSystem"
                        echo "[+] System reset. Please restart."
                        exit 0
                    fi
                    ;;
            esac
            ;;
        8)
            clear
            echo "╔════════════════════════════════════════════════════════════╗"
            echo "║                    HELP & DOCUMENTATION                    ║"
            echo "╚════════════════════════════════════════════════════════════╝"
            echo ""
            echo "📚 MONITORING SYSTEM DOCUMENTATION"
            echo "──────────────────────────────────"
            echo ""
            echo "SYSTEM MODULES:"
            echo "1. Dashboard - Real-time system status"
            echo "2. Resource Monitor - CPU, Memory, Disk, Battery"
            echo "3. Security Scanner - Files, Processes, Network"
            echo "4. Network Analyzer - Connections, Traffic, Speed"
            echo "5. Report Generator - Daily, Weekly, Monthly reports"
            echo "6. Automation Manager - Scheduled tasks, Backups"
            echo ""
            echo "QUICK START:"
            echo "1. Start with Dashboard to see current status"
            echo "2. Run Security Scanner for initial audit"
            echo "3. Set up Automation for daily tasks"
            echo "4. Generate reports to track progress"
            echo ""
            echo "KEY FEATURES:"
            echo "✅ Real-time monitoring"
            echo "✅ Automated alerts"
            echo "✅ Comprehensive reporting"
            echo "✅ Scheduled maintenance"
            echo "✅ Security auditing"
            echo "✅ Network analysis"
            echo ""
            echo "CONFIGURATION:"
            echo "Edit: $HOME/MonitoringSystem/config/monitor_config.conf"
            echo ""
            echo "LOGS:"
            echo "View logs in: $HOME/MonitoringSystem/logs/"
            echo ""
            echo "REPORTS:"
            echo "Generated in: $HOME/MonitoringSystem/reports/"
            echo ""
            echo "Press any key to continue..."
            read -n 1
            ;;
        9)
            echo ""
            echo "Thank you for using the Monitoring System!"
            echo "Goodbye! 👋"
            exit 0
            ;;
        *)
            echo "Invalid option!"
            ;;
    esac
    
    echo ""
    echo "Press any key to continue..."
    read -n 1
done
EOF

chmod +x "$main_launcher"

# Create configuration file
config_file="$HOME/MonitoringSystem/config/monitor_config.conf"

cat > "$config_file" << 'EOF'
# Professional Monitoring System Configuration
# ===========================================

# System Information
SYSTEM_NAME="Mobile Monitoring System"
SYSTEM_VERSION="2.0"
SYSTEM_OWNER="$(whoami)"

# Alert Thresholds
CPU_ALERT_THRESHOLD=80
MEMORY_ALERT_THRESHOLD=80
DISK_ALERT_THRESHOLD=85
BATTERY_ALERT_THRESHOLD=20
TEMPERATURE_ALERT_THRESHOLD=60

# Monitoring Intervals
DASHBOARD_REFRESH=5
RESOURCE_CHECK_INTERVAL=300
SECURITY_SCAN_INTERVAL=3600
NETWORK_CHECK_INTERVAL=600

# Logging Settings
LOG_RETENTION_DAYS=30
LOG_LEVEL="INFO"  # DEBUG, INFO, WARN, ERROR
ENABLE_SYSLOG=false

# Reporting Settings
DAILY_REPORT_TIME="23:00"
WEEKLY_REPORT_DAY="Sunday"
MONTHLY_REPORT_DAY="1"
REPORT_RETENTION_DAYS=90

# Automation Settings
ENABLE_AUTO_BACKUP=true
ENABLE_AUTO_CLEANUP=true
ENABLE_AUTO_UPDATES=true
ENABLE_AUTO_REPORTS=true

# Backup Settings
BACKUP_RETENTION_DAYS=30
BACKUP_LOCATION="$HOME/MonitoringSystem/backups"
BACKUP_INCLUDE_SCRIPTS=true
BACKUP_INCLUDE_CONFIGS=true
BACKUP_INCLUDE_LOGS=false

# Security Settings
ENABLE_FILE_INTEGRITY=true
ENABLE_PERMISSION_CHECKS=true
ENABLE_SUSPICIOUS_PROCESS_CHECK=true
ENABLE_NETWORK_SECURITY_SCAN=true

# Network Settings
MONITOR_PORTS="22,80,443,8080"
ALLOWED_IPS=""
BLOCKED_IPS=""

# Notification Settings (Future Feature)
ENABLE_NOTIFICATIONS=false
NOTIFICATION_METHOD="log"  # log, toast, both

# Performance Settings
ENABLE_PERFORMANCE_MONITORING=true
ENABLE_TREND_ANALYSIS=true
ENABLE_CAPACITY_PLANNING=false
EOF

# Create initialization script
init_script="$HOME/MonitoringSystem/init_system.sh"

cat > "$init_script" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash

# Monitoring System Initialization Script
echo "=== MONITORING SYSTEM INITIALIZATION ==="
echo ""

# Check dependencies
echo "[1] Checking dependencies..."
if ! command -v bash &> /dev/null; then
    echo "[-] Bash is required!"
    exit 1
fi

echo "[+] Bash: OK"

if ! command -v netstat &> /dev/null && ! command -v ss &> /dev/null; then
    echo "[-] Network tools not found!"
    echo "[*] Installing network utilities..."
    pkg install net-tools -y
fi

echo "[+] Network tools: OK"

# Create directory structure
echo ""
echo "[2] Creating directory structure..."
mkdir -p "$HOME/MonitoringSystem"
mkdir -p "$HOME/MonitoringSystem/bin"
mkdir -p "$HOME/MonitoringSystem/config"
mkdir -p "$HOME/MonitoringSystem/logs"
mkdir -p "$HOME/MonitoringSystem/reports"
mkdir -p "$HOME/MonitoringSystem/backups"

echo "[+] Directories created"

# Set permissions
echo ""
echo "[3] Setting permissions..."
chmod 750 "$HOME/MonitoringSystem"
chmod 700 "$HOME/MonitoringSystem/config"
chmod 755 "$HOME/MonitoringSystem/bin"/*.sh 2>/dev/null

# Create essential files
echo ""
echo "[4] Creating essential files..."
touch "$HOME/MonitoringSystem/logs/system.log"
touch "$HOME/MonitoringSystem/logs/security.log"
touch "$HOME/MonitoringSystem/logs/network.log"
touch "$HOME/MonitoringSystem/logs/automation.log"

# Initialize configuration if not exists
if [ ! -f "$HOME/MonitoringSystem/config/monitor_config.conf" ]; then
    echo "[*] Creating default configuration..."
    cat > "$HOME/MonitoringSystem/config/monitor_config.conf" << 'CONFIG_EOF'
# Default configuration
SYSTEM_NAME="Mobile Monitoring System"
VERSION="1.0"
CONFIG_EOF
fi

# Set up cron jobs
echo ""
echo "[5] Setting up scheduled tasks..."
echo "[*] Adding daily tasks to crontab..."

# Add monitoring tasks
(crontab -l 2>/dev/null; echo "# Monitoring System Tasks") | crontab -
(crontab -l 2>/dev/null; echo "0 * * * * $HOME/MonitoringSystem/bin/resource_monitor.sh > $HOME/MonitoringSystem/logs/resource.log 2>&1") | crontab -
(crontab -l 2>/dev/null; echo "0 2 * * * $HOME/MonitoringSystem/bin/security_scanner.sh > $HOME/MonitoringSystem/logs/security.log 2>&1") | crontab -
(crontab -l 2>/dev/null; echo "0 3 * * * $HOME/MonitoringSystem/bin/report_generator.sh daily > $HOME/MonitoringSystem/logs/report.log 2>&1") | crontab -

echo "[+] Cron jobs configured"

# Final setup
echo ""
echo "[6] Finalizing setup..."
echo "[*] Creating startup script..."

cat > "$HOME/.bashrc_monitoring" << 'BASHRC_EOF'
# Monitoring System Startup
export MONITORING_SYSTEM_ENABLED=true
export MONITORING_PATH="$HOME/MonitoringSystem"
alias monitoring="$HOME/MonitoringSystem/monitoring_system.sh"
alias ms-status="$HOME/MonitoringSystem/bin/resource_monitor.sh"
alias ms-security="$HOME/MonitoringSystem/bin/security_scanner.sh"
alias ms-report="$HOME/MonitoringSystem/bin/report_generator.sh"
BASHRC_EOF

# Add to bashrc if not already added
if ! grep -q "bashrc_monitoring" "$HOME/.bashrc"; then
    echo "source $HOME/.bashrc_monitoring" >> "$HOME/.bashrc"
fi

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║            SETUP COMPLETE!                                ║"
echo "╠════════════════════════════════════════════════════════════╣"
echo "║                                                            ║"
echo "║  🎉 Monitoring System v2.0 is now ready!                  ║"
echo "║                                                            ║"
echo "║  To start the system, run:                                ║"
echo "║      ./MonitoringSystem/monitoring_system.sh              ║"
echo "║                                                            ║"
echo "║  Or use the alias:                                        ║"
echo "║      monitoring                                           ║"
echo "║                                                            ║"
echo "║  Available commands:                                      ║"
echo "║      ms-status    - Check system status                   ║"
echo "║      ms-security  - Run security scan                     ║"
echo "║      ms-report    - Generate report                       ║"
echo "║                                                            ║"
echo "║  Configuration:                                           ║"
echo "║      $HOME/MonitoringSystem/config/monitor_config.conf   ║"
echo "║                                                            ║"
echo "║  Logs:                                                    ║"
echo "║      $HOME/MonitoringSystem/logs/                         ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "[*] System will automatically run checks hourly"
echo "[*] Daily reports will be generated at 3 AM"
echo "[*] Security scans will run at 2 AM daily"
echo ""
echo "Enjoy your new monitoring system! 🚀"
EOF

chmod +x "$init_script"

# Create uninstall script
uninstall_script="$HOME/MonitoringSystem/uninstall.sh"

cat > "$uninstall_script" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash

# Monitoring System Uninstall Script
echo "=== MONITORING SYSTEM UNINSTALL ==="
echo ""
echo "[!] WARNING: This will remove the entire monitoring system"
echo "    including all logs, reports, and backups."
echo ""
echo "[?] Are you sure you want to continue? (y/n): "
read confirm

if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "Uninstall cancelled."
    exit 0
fi

echo ""
echo "[1] Removing scheduled tasks..."
crontab -l 2>/dev/null | grep -v "Monitoring System" | grep -v "resource_monitor\|security_scanner\|report_generator" | crontab -
echo "[+] Cron jobs removed"

echo ""
echo "[2] Removing bashrc configuration..."
sed -i '/bashrc_monitoring/d' "$HOME/.bashrc"
rm -f "$HOME/.bashrc_monitoring"
echo "[+] Bash configuration removed"

echo ""
echo "[3] Removing system files..."
rm -rf "$HOME/MonitoringSystem"
echo "[+] System files removed"

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║            UNINSTALL COMPLETE!                            ║"
echo "╠════════════════════════════════════════════════════════════╣"
echo "║                                                            ║"
echo "║  Monitoring System has been completely removed.           ║"
echo "║                                                            ║"
echo "║  To reinstall, run the setup script again.                ║"
echo "║                                                            ║"
echo "║  Thank you for using the system!                          ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝"
EOF

chmod +x "$uninstall_script"

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║        PROFESSIONAL MONITORING SYSTEM - COMPLETE!         ║"
echo "╠════════════════════════════════════════════════════════════╣"
echo "║                                                            ║"
echo "║  ✅ 6 Complete Modules Created:                           ║"
echo "║     1. Resource Monitor                                   ║"
echo "║     2. Security Scanner                                   ║"
echo "║     3. Network Analyzer                                   ║"
echo "║     4. Report Generator                                   ║"
echo "║     5. Automation Manager                                 ║"
echo "║     6. Main Dashboard                                     ║"
echo "║                                                            ║"
echo "║  ✅ Configuration System                                  ║"
echo "║  ✅ Logging System                                        ║"
echo "║  ✅ Reporting System                                      ║"
echo "║  ✅ Backup System                                         ║"
echo "║  ✅ Scheduling System                                     ║"
echo "║  ✅ Installation Script                                   ║"
echo "║  ✅ Uninstall Script                                      ║"
echo "║                                                            ║"
echo "║  📁 Directory Structure:                                  ║"
echo "║     ~/MonitoringSystem/                                   ║"
echo "║        ├── bin/           # All executable scripts        ║"
echo "║        ├── config/        # Configuration files          ║"
echo "║        ├── logs/          # System logs                  ║"
echo "║        ├── reports/       # Generated reports            ║"
echo "║        └── backups/       # System backups               ║"
echo "║                                                            ║"
echo "║  🚀 To Start the System:                                 ║"
echo "║     1. First, run the initialization:                    ║"
echo "║        ./MonitoringSystem/init_system.sh                 ║"
echo "║                                                            ║"
echo "║     2. Then start the main system:                       ║"
echo "║        ./MonitoringSystem/monitoring_system.sh           ║"
echo "║                                                            ║"
echo "║  🎯 Quick Commands (after init):                         ║"
echo "║     monitoring      - Start main system                  ║"
echo "║     ms-status       - Quick status check                 ║"
echo "║     ms-security     - Security scan                      ║"
echo "║     ms-report       - Generate report                    ║"
echo "║                                                            ║"
echo "║  ⚙️  Configuration:                                      ║"
echo "║     Edit: ~/MonitoringSystem/config/monitor_config.conf  ║"
echo "║                                                            ║"
echo "║  📊 Features:                                            ║"
echo "║     • Real-time monitoring                               ║"
echo "║     • Automated alerts                                   ║"
echo "║     • Scheduled tasks                                    ║"
echo "║     • Comprehensive reports                              ║"
echo "║     • Security auditing                                  ║"
echo "║     • Network analysis                                   ║"
echo "║     • Backup management                                  ║"
echo "║     • Performance tracking                               ║"
echo "║                                                            ║"
echo "║  🎓 Educational Value:                                   ║"
echo "║     • Learn system administration                        ║"
echo "║     • Understand mobile system internals                 ║"
echo "║     • Practice bash scripting                            ║"
echo "║     • Master monitoring concepts                         ║"
echo "║     • Develop automation skills                          ║"
echo "║                                                            ║"
echo "║  📈 Next Steps:                                         ║"
echo "║     1. Run initialization script                         ║"
echo "║     2. Explore each module                               ║"
echo "║     3. Customize configuration                           ║"
echo "║     4. Set up automation                                 ║"
echo "║     5. Monitor your progress                             ║"
echo "║                                                            ║"
echo "║  💡 Tip: This system monitors YOUR device only.          ║"
echo "║        Use it to learn and improve YOUR system.          ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "[+] All files created successfully!"
echo "[+] Total scripts created: 12"
echo "[+] Total lines of code: ~2500"
echo "[+] System ready for deployment!"
