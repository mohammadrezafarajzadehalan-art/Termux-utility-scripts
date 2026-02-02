#!/data/data/com.termux/files/usr/bin/bash

echo "[*] File Organizer"
echo "[*] Organizing files in current directory..."
echo ""

# Sakhtane folder haye asli
folders=("Images" "Documents" "Videos" "Music" "Archives" "Scripts" "Others")

for folder in "${folders[@]}"; do
    if [ ! -d "$folder" ]; then
        mkdir "$folder"
        echo "[+] Created folder: $folder"
    fi
done

# Move kardane file ha
file_count=0

for file in *; do
    if [ -f "$file" ]; then
        ext="${file##*.}"
        ext_lower=$(echo "$ext" | tr '[:upper:]' '[:lower:]')
        
        case "$ext_lower" in
            jpg|jpeg|png|gif)
                mv "$file" "Images/"
                echo "[+] Moved $file to Images/"
                ;;
            pdf|doc|txt|odt)
                mv "$file" "Documents/"
                echo "[+] Moved $file to Documents/"
                ;;
            mp4|avi|mkv)
                mv "$file" "Videos/"
                echo "[+] Moved $file to Videos/"
                ;;
            mp3|wav|ogg)
                mv "$file" "Music/"
                echo "[+] Moved $file to Music/"
                ;;
            zip|rar|tar|gz)
                mv "$file" "Archives/"
                echo "[+] Moved $file to Archives/"
                ;;
            sh|py|js)
                mv "$file" "Scripts/"
                echo "[+] Moved $file to Scripts/"
                ;;
            *)
                if [ "$file" != "$0" ]; then
                    mv "$file" "Others/"
                    echo "[+] Moved $file to Others/"
                fi
                ;;
        esac
        file_count=$((file_count + 1))
    fi
done

echo ""
echo "[*] Done! Organized $file_count files."
