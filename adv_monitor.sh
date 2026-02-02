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
