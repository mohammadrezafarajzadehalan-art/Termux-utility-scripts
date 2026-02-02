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
