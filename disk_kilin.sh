#!/data/data/com.termux/files/usr/bin/bash

echo "[*] Disk Cleaner"
echo "======================"
echo ""

# Show disk usage
echo "Current disk usage:"
du -sh ~/ 2>/dev/null || echo "Cannot check disk usage"
echo ""

# Find large files
echo "Finding large files (>10MB)..."
find ~/ -type f -size +10M 2>/dev/null | head -10
echo ""

# Clean temp files
echo "[?] Clean temporary files? (y/n): "
read answer

if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    echo "Cleaning..."
    rm -rf /tmp/* 2>/dev/null
    rm -rf ~/.cache/* 2>/dev/null
    echo "[+] Cleanup completed!"
else
    echo "[-] Cleanup skipped."
fi
