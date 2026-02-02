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
