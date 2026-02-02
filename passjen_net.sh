#!/data/data/com.termux/files/usr/bin/bash

echo "[*] Network Checker"
echo "======================"
echo ""

# Check internet
echo "[1] Testing internet connection..."
ping -c 2 8.8.8.8 > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "[+] Internet: CONNECTED"
else
    echo "[-] Internet: NO CONNECTION"
fi

echo ""

# Show IP
echo "[2] Your IP Address:"
ip addr show | grep -oE 'inet [0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | grep -v "127.0.0.1" || echo "No IP found"

echo ""

# Check local services
echo "[3] Checking local services..."
echo "Port 80 (HTTP):"
timeout 1 bash -c "echo >/dev/tcp/localhost/80" 2>/dev/null && echo "  [+] OPEN" || echo "  [-] CLOSED"
echo "Port 22 (SSH):"
timeout 1 bash -c "echo >/dev/tcp/localhost/22" 2>/dev/null && echo "  [+] OPEN" || echo "  [-] CLOSED"
