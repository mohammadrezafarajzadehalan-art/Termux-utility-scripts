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
