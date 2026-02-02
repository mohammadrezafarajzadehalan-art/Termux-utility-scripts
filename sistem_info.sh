#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo "     SYSTEM INFO - TERMUX"
echo "======================================"
echo ""

# 1. Etelaat Memory
echo "[+] Memory Information:"
free -h 2>/dev/null || echo "Memory info not available"
echo ""

# 2. Disk Usage
echo "[+] Disk Usage:"
df -h /data 2>/dev/null
echo ""

# 3. CPU Info
echo "[+] CPU Information:"
cat /proc/cpuinfo 2>/dev/null | grep -E "processor|model name" | head -2
echo ""

# 4. Network Info
echo "[+] Network:"
ip addr show 2>/dev/null | grep -E "inet.*global" || echo "Network info not available"
echo ""

# 5. Termux Info
echo "[+] Termux Info:"
echo "User: $(whoami)"
echo "Home: $HOME"
echo "Date: $(date)"
echo ""

echo "======================================"
