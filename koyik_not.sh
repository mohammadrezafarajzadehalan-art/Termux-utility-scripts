#!/data/data/com.termux/files/usr/bin/bash

notes_file="$HOME/quick_notes.txt"

echo "======================================"
echo "     QUICK NOTES"
echo "======================================"
echo ""

echo "1. View notes"
echo "2. Add note"
echo "3. Clear notes"
echo "4. Exit"
echo ""

echo "[?] Select option (1-4): "
read option

case $option in
    1)
        echo ""
        echo "Your notes:"
        echo "============"
        if [ -f "$notes_file" ]; then
            cat "$notes_file"
        else
            echo "No notes yet!"
        fi
        ;;
    2)
        echo ""
        echo "[?] Enter your note:"
        read note
        echo "$(date): $note" >> "$notes_file"
        echo "[+] Note saved!"
        ;;
    3)
        rm -f "$notes_file"
        echo "[+] All notes cleared!"
        ;;
    4)
        echo "Goodbye!"
        ;;
    *)
        echo "Invalid option!"
        ;;
esac
