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
echo "   QUICK SERVER - TERMUX"
echo "========================================="
echo -e "${RESET}"

# Check kardane Python
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
elif command -v python &> /dev/null; then
    PYTHON_CMD="python"
else
    echo -e "${RED}[!] Python is not installed!${RESET}"
    echo "Install it with: pkg install python"
    exit 1
fi

# Porsidan port
echo -e "${YELLOW}[?] Enter port number (default: 8080): ${RESET}"
read -r PORT
PORT=${PORT:-8080}

# Check kardane directory
echo -e "${YELLOW}[?] Enter directory to serve (default: current): ${RESET}"
read -r SERVE_DIR
SERVEDIR=${SERVE_DIR:-$(pwd)}

# Check kardane directory
if [ ! -d "$SERVEDIR" ]; then
    echo -e "${RED}[!] Directory does not exist!${RESET}"
    exit 1
fi

clear
echo -e "${GREEN}"
echo "========================================="
echo "   SERVER STARTED"
echo "========================================="
echo -e "${RESET}"
echo -e "${YELLOW}[*] Serving directory:${RESET} $SERVEDIR"
echo -e "${YELLOW}[*] Port:${RESET} $PORT"
echo -e "${YELLOW}[*] Server IP addresses:${RESET}"

# Namayesh IP address ha
ip addr show | grep -E "inet.*global" | awk '{print "  - " $2}'

echo -e "\n${YELLOW}[*] Access URLs:${RESET}"
echo "  - Local: http://localhost:$PORT"
echo "  - Network: http://YOUR_IP:$PORT"
echo -e "\n${RED}[!] Press Ctrl+C to stop the server${RESET}"
echo -e "\n${BLUE}=========================================${RESET}"

# Shorooye server
cd "$SERVEDIR" || exit
$PYTHON_CMD -m http.server "$PORT"
