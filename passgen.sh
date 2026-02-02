#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo "     PASSWORD GENERATOR"
echo "======================================"
echo ""

echo "[?] How many passwords? (1-10): "
read count

echo "[?] Password length? (8-32): "
read length

echo ""
echo "Generated Passwords:"
echo "======================"

for i in $(seq 1 $count); do
    # Generate random password
    password=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $length | head -n 1)
    echo "Password $i: $password"
done

echo ""
echo "[*] Tip: Use a password manager to save these!"
