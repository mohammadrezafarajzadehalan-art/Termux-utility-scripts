#!/data/data/com.termux/files/usr/bin/bash

# Rango
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
RESET='\033[0m'

clear
echo -e "${CYAN}"
echo "========================================="
echo "   NETWORK TESTER - TERMUX"
echo "========================================="
echo -e "${RESET}"

# Function test internet
test_internet() {
    echo -e "${YELLOW}[*] Testing internet connection...${RESET}"
    
    # Test ba ping
    if ping -c 3 8.8.8.8 &> /dev/null; then
        echo -e "${GREEN}[+] Ping to 8.8.8.8: SUCCESS${RESET}"
    else
        echo -e "${RED}[-] Ping to 8.8.8.8: FAILED${RESET}"
    fi
    
    # Test ba DNS
    if nslookup google.com &> /dev/null; then
        echo -e "${GREEN}[+] DNS resolution: SUCCESS${RESET}"
    else
        echo -e "${RED}[-] DNS resolution: FAILED${RESET}"
    fi
    
    # Test ba curl
    if curl -s --connect-timeout 10 https://www.google.com &> /dev/null; then
        echo -e "${GREEN}[+] HTTPS connection: SUCCESS${RESET}"
    else
        echo -e "${RED}[-] HTTPS connection: FAILED${RESET}"
    fi
}

# Function test speed
test_speed() {
    echo -e "\n${YELLOW}[*] Testing download speed...${RESET}"
    echo "This may take a moment..."
    
    # Download test
    start_time=$(date +%s)
    if curl -s -o /dev/null https://speed.hetzner.de/100MB.bin; then
        end_time=$(date +%s)
        duration=$((end_time - start_time))
        
        if [ "$duration" -gt 0 ]; then
            speed=$((100 * 8 / duration))
            echo -e "${GREEN}[+] Download speed: ~$speed Mbps${RESET}"
        else
            echo -e "${GREEN}[+] Download speed: Very fast!${RESET}"
        fi
    else
        echo -e "${RED}[-] Download test failed${RESET}"
    fi
}

# Namayesh network info
echo -e "${YELLOW}[*] Network Information:${RESET}"
echo ""

# IP address
ip=$(ip addr show | grep -E "inet.*global" | head -1 | awk '{print $2}')
echo -e "${BLUE}IP Address:${RESET} $ip"

# Gateway
gateway=$(ip route | grep default | awk '{print $3}')
echo -e "${BLUE}Gateway:${RESET} $gateway"

# DNS
dns=$(grep nameserver /etc/resolv.conf 2>/dev/null | awk '{print $2}' | head -1)
echo -e "${BLUE}DNS:${RESET} $dns"

# Test internet
test_internet

# Porside baraye speed test
echo -e "\n${YELLOW}[?] Run speed test? (y/n): ${RESET}"
read -r run_speed

if [[ "$run_speed" == "y" || "$run_speed" == "Y" ]]; then
    test_speed
fi

# Port scan option
echo -e "\n${YELLOW}[?] Check open ports on localhost? (y/n): ${RESET}"
read -r check_ports

if [[ "$check_ports" == "y" || "$check_ports" == "Y" ]]; then
    echo -e "\n${YELLOW}[*] Checking common ports on localhost...${RESET}"
    for port in 22 80 443 8080 3000; do
        if nc -z localhost "$port" 2>/dev/null; then
            echo -e "${GREEN}[+] Port $port: OPEN${RESET}"
        else
            echo -e "${RED}[-] Port $port: CLOSED${RESET}"
        fi
    done
fi

echo -e "\n${BLUE}=========================================${RESET}"
