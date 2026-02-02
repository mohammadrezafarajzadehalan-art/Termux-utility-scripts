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
