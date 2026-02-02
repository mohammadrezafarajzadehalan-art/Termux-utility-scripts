#!/data/data/com.termux/files/usr/bin/bash

# Ebarat Error
if ! command -v termux-wifi-scaninfo &> /dev/null; then
    echo "Error: termux-api package is not installed!"
    echo "Please install it with: pkg install termux-api"
    exit 1
fi

# Rango
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
BLUE='\033[1;34m'
RESET='\033[0m'

clear
echo -e "${BLUE}"
echo "========================================="
echo "   WIFI SCANNER - TERMUX"
echo "========================================="
echo -e "${RESET}"

echo -e "${YELLOW}[*] Scanning for WiFi networks...${RESET}"
echo "This may take 10-15 seconds..."
echo ""

# Scan kardane WiFi ha
result=$(termux-wifi-scaninfo)

if [ -z "$result" ]; then
    echo -e "${RED}[!] No WiFi networks found or permission denied${RESET}"
    echo "Make sure:"
    echo "1. WiFi is enabled on your device"
    echo "2. Termux has location permission"
    exit 1
fi

# Shomaresh tedad WiFi ha
count=$(echo "$result" | grep -c "bssid")
echo -e "${GREEN}[+] Found $count WiFi networks${RESET}"
echo ""

# Namayesh WiFi ha
echo "$result" | while IFS= read -r line; do
    if echo "$line" | grep -q "ssid"; then
        ssid=$(echo "$line" | cut -d':' -f2- | xargs)
        echo -e "${GREEN}Network:${RESET} $ssid"
    elif echo "$line" | grep -q "bssid"; then
        bssid=$(echo "$line" | cut -d':' -f2- | xargs)
        echo -e "${BLUE}BSSID:${RESET} $bssid"
    elif echo "$line" | grep -q "rssi"; then
        rssi=$(echo "$line" | cut -d':' -f2- | xargs)
        # Taghire RSSI be signal strength
        if [ "$rssi" -gt -50 ]; then
            signal="Excellent"
            color="${GREEN}"
        elif [ "$rssi" -gt -60 ]; then
            signal="Good"
            color="${YELLOW}"
        elif [ "$rssi" -gt -70 ]; then
            signal="Fair"
            color="${YELLOW}"
        else
            signal="Poor"
            color="${RED}"
        fi
        echo -e "${BLUE}Signal:${RESET} $color$signal ($rssi dBm)${RESET}"
        echo "----------------------------------------"
    fi
done

echo -e "\n${BLUE}=========================================${RESET}"
