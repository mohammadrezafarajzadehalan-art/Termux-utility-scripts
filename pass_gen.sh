#!/data/data/com.termux/files/usr/bin/bash

# Rango
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
RED='\033[1;31m'
CYAN='\033[1;36m'
RESET='\033[0m'

clear
echo -e "${CYAN}"
echo "========================================="
echo "   PASSWORD GENERATOR - TERMUX"
echo "========================================="
echo -e "${RESET}"

# Function generate password
generate_password() {
    local length=$1
    local use_special=$2
    
    # Character sets
    local lowercase="abcdefghijklmnopqrstuvwxyz"
    local uppercase="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local numbers="0123456789"
    local special="!@#$%^&*()_+-=[]{}|;:,.<>?"
    
    # Combine character sets
    local chars="$lowercase$uppercase$numbers"
    if [ "$use_special" = true ]; then
        chars="$chars$special"
    fi
    
    # Generate password
    local password=""
    for i in $(seq 1 "$length"); do
        # Entekhab random character
        local rand_index=$((RANDOM % ${#chars}))
        password="$password${chars:$rand_index:1}"
    done
    
    echo "$password"
}

# Porside etelaat
echo -e "${YELLOW}[?] Password length (default: 12): ${RESET}"
read -r LENGTH
LENGTH=${LENGTH:-12}

echo -e "${YELLOW}[?] Include special characters? (y/n, default: y): ${RESET}"
read -r USE_SPECIAL
USE_SPECIAL=${USE_SPECIAL:-y}

if [[ "$USE_SPECIAL" == "y" || "$USE_SPECIAL" == "Y" ]]; then
    SPECIAL=true
else
    SPECIAL=false
fi

echo -e "${YELLOW}[?] How many passwords to generate? (default: 5): ${RESET}"
read -r COUNT
COUNT=${COUNT:-5}

clear
echo -e "${GREEN}"
echo "========================================="
echo "   GENERATED PASSWORDS"
echo "========================================="
echo -e "${RESET}"
echo -e "${YELLOW}[*] Length:${RESET} $LENGTH"
echo -e "${YELLOW}[*] Special characters:${RESET} $SPECIAL"
echo -e "${YELLOW}[*] Count:${RESET} $COUNT"
echo -e "\n${BLUE}=========================================${RESET}\n"

# Generate kardane password ha
for i in $(seq 1 "$COUNT"); do
    password=$(generate_password "$LENGTH" "$SPECIAL")
    echo -e "${GREEN}Password $i:${RESET} $password"
done

echo -e "\n${BLUE}=========================================${RESET}"
echo -e "${YELLOW}[*] Tips for strong passwords:${RESET}"
echo "1. Use at least 12 characters"
echo "2. Mix uppercase and lowercase"
echo "3. Include numbers and symbols"
echo "4. Avoid common words"
echo "5. Don't reuse passwords"
