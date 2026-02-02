#!/data/data/com.termux/files/usr/bin/bash

# Rango
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
RESET='\033[0m'

clear
echo -e "${CYAN}"
echo "========================================="
echo "   SYSTEM INFORMATION - TERMUX"
echo "========================================="
echo -e "${RESET}"

echo -e "${YELLOW}[+] CPU Information:${RESET}"
cat /proc/cpuinfo | grep -E "processor|model name" | head -4

echo -e "\n${YELLOW}[+] Memory Information:${RESET}"
free -h

echo -e "\n${YELLOW}[+] Storage Information:${RESET}"
df -h /data/data/com.termux/files/home

echo -e "\n${YELLOW}[+] Battery Information:${RESET}"
termux-battery-status 2>/dev/null || echo "Battery info not available"

echo -e "\n${YELLOW}[+] Network Information:${RESET}"
ifconfig wlan0 2>/dev/null | grep -E "inet|ether" || ip addr show 2>/dev/null | grep -E "inet.*global"

echo -e "\n${YELLOW}[+] Termux Packages:${RESET}"
pkg list-installed | wc -l | awk '{print "Installed packages: "$1}'

echo -e "\n${GREEN}[+] Disk Usage of Home Directory:${RESET}"
du -sh ~/ | awk '{print "Home directory: "$1}'

echo -e "\n${BLUE}=========================================${RESET}"
