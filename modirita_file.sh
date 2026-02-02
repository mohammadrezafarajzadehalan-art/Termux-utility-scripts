#!/data/data/com.termux/files/usr/bin/bash

# Rango
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
RED='\033[1;31m'
RESET='\033[0m'

clear
echo -e "${BLUE}"
echo "========================================="
echo "   FILE ORGANIZER - TERMUX"
echo "========================================="
echo -e "${RESET}"

# Etelaat Directory
DIR="$HOME"

echo -e "${YELLOW}[*] Current directory: $DIR${RESET}"
echo -e "${YELLOW}[*] Organizing files by extension...${RESET}"
echo ""

# Sakhtane Directory haye mokhtalef
mkdir -p "$DIR/Organized/Images"
mkdir -p "$DIR/Organized/Documents"
mkdir -p "$DIR/Organized/Videos"
mkdir -p "$DIR/Organized/Music"
mkdir -p "$DIR/Organized/Archives"
mkdir -p "$DIR/Organized/Scripts"
mkdir -p "$DIR/Organized/Others"

# Shomaresh file haye ghabli
total_files=$(find "$DIR" -maxdepth 1 -type f | wc -l)
echo -e "${GREEN}[+] Total files found: $total_files${RESET}"

# Move kardane file ha bar asase extension
moved_count=0

for file in "$DIR"/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        extension="${filename##*.}"
        
        # Bar asase extension directory moshakhas shavad
        case "$extension" in
            jpg|jpeg|png|gif|bmp|webp)
                dest="$DIR/Organized/Images"
                ;;
            pdf|doc|docx|txt|odt|rtf)
                dest="$DIR/Organized/Documents"
                ;;
            mp4|avi|mkv|mov|flv)
                dest="$DIR/Organized/Videos"
                ;;
            mp3|wav|ogg|flac)
                dest="$DIR/Organized/Music"
                ;;
            zip|rar|tar|gz|7z)
                dest="$DIR/Organized/Archives"
                ;;
            sh|bash|py|js|html|css)
                dest="$DIR/Organized/Scripts"
                ;;
            *)
                dest="$DIR/Organized/Others"
                ;;
        esac
        
        # Move kardan file
        mv "$file" "$dest/" 2>/dev/null
        if [ $? -eq 0 ]; then
            moved_count=$((moved_count + 1))
            echo -e "${GREEN}[+] Moved: $filename to $dest${RESET}"
        fi
    fi
done

echo -e "\n${YELLOW}[*] Organization complete!${RESET}"
echo -e "${GREEN}[+] Total files moved: $moved_count${RESET}"
echo -e "\n${BLUE}Organized folder structure:${RESET}"
tree "$DIR/Organized" --filelimit 10 2>/dev/null || ls -R "$DIR/Organized"

echo -e "\n${BLUE}=========================================${RESET}"
