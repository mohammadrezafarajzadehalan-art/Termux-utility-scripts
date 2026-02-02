#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo "     SIMPLE CALCULATOR"
echo "======================================"
echo ""

while true; do
    echo "[?] Enter first number:"
    read num1
    
    echo "[?] Enter operation (+, -, *, /):"
    read op
    
    echo "[?] Enter second number:"
    read num2
    
    # Calculate
    case $op in
        "+")
            result=$(echo "$num1 + $num2" | bc 2>/dev/null || echo $((num1 + num2)))
            ;;
        "-")
            result=$(echo "$num1 - $num2" | bc 2>/dev/null || echo $((num1 - num2)))
            ;;
        "*")
            result=$(echo "$num1 * $num2" | bc 2>/dev/null || echo $((num1 * num2)))
            ;;
        "/")
            if [ "$num2" -eq 0 ]; then
                result="Error: Division by zero"
            else
                result=$(echo "scale=2; $num1 / $num2" | bc 2>/dev/null || echo "Need 'bc' package")
            fi
            ;;
        *)
            result="Invalid operation"
            ;;
    esac
    
    echo ""
    echo "Result: $num1 $op $num2 = $result"
    echo ""
    
    echo "[?] Another calculation? (y/n):"
    read again
    
    if [ "$again" != "y" ] && [ "$again" != "Y" ]; then
        break
    fi
    echo ""
done

echo "Goodbye!"
