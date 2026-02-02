#!/bin/bash
# Romanized Bash - Progressiv Barname
# Version 1.0

# Rang haye mokhtalef
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function asli
main_menu() {
    clear
    echo -e "${GREEN}"
    echo "┌─────────────────────────────────────┐"
    echo "│  Progressive Barname - V 1.0        │"
    echo "│                                     │"
    echo "│  1. Shoroo ye kare jadid           │"
    echo "│  2. List proje haye ghabli         │"
    echo "│  3. Help va rahnamayi              │"
    echo "│  4. Khabar dadan az feature jadid  │"
    echo "│  5. Khorooj                        │"
    echo "└─────────────────────────────────────┘"
    echo -e "${NC}"
    
    read -p "Entekhabe khod ra vared konid (1-5): " choice
    
    case $choice in
        1)
            start_new_project
            ;;
        2)
            list_projects
            ;;
        3)
            show_help
            ;;
        4)
            request_feature
            ;;
        5)
            echo "Khodahafez! Ba arezooye ruz e khub :)"
            exit 0
            ;;
        *)
            echo -e "${RED}Entekhab ghabele qabol nist!${NC}"
            sleep 2
            main_menu
            ;;
    esac
}

# Function baraye shoroo ye proje jadid
start_new_project() {
    clear
    echo -e "${BLUE}=== SHOROO YE PROJE JADID ===${NC}"
    echo ""
    
    read -p "Name proje ra vared konid: " project_name
    read -p "Tozihat (kotah): " description
    
    # Sakhtane file proje
    timestamp=$(date +"%Y%m%d_%H%M%S")
    filename="${project_name}_${timestamp}.prog"
    
    echo "# Proje: $project_name" > "$filename"
    echo "# Sakhte shode dar: $(date)" >> "$filename"
    echo "# Tozihat: $description" >> "$filename"
    echo "# Marhale: 1 - Shoroo" >> "$filename"
    echo "" >> "$filename"
    echo "echo 'Proje $project_name shoroo shod!'" >> "$filename"
    
    echo -e "${GREEN}"
    echo "Proje '$project_name' ba movafaqiyat sakhte shod!"
    echo "File: $filename"
    echo -e "${NC}"
    
    read -p "Aya mikhahid file ra run konid? (y/n): " run_choice
    if [[ "$run_choice" == "y" || "$run_choice" == "Y" ]]; then
        bash "$filename"
    fi
    
    read -p "Press Enter to continue..."
    main_menu
}

# Function baraye list projeha
list_projects() {
    clear
    echo -e "${YELLOW}=== PROJE HAYE GHABLI ===${NC}"
    echo ""
    
    if ls *.prog 2>/dev/null; then
        echo ""
        echo -e "${GREEN}File haye proje peyda shod.${NC}"
    else
        echo -e "${RED}Hich file proje i peyda nashod.${NC}"
    fi
    
    echo ""
    read -p "Press Enter to continue..."
    main_menu
}

# Function help
show_help() {
    clear
    echo -e "${BLUE}=== HELP VA RAHNAMAYI ===${NC}"
    echo ""
    echo "In barname ye progressive CLI ast ke:"
    echo "1. Mimkan dad shoroo ye kare jadid"
    echo "2. Dar har marhale feature jadid ezafe mishavad"
    echo "3. Ba hame proje haye ghabli ra negah midarad"
    echo ""
    echo "Feature haye version 1.0:"
    echo "- Menu asli"
    echo "- Sakhtane proje jadid"
    echo "- List kardane proje haye ghabli"
    echo "- Request feature jadid"
    echo ""
    echo -e "${YELLOW}Dar marhale badi chizi ezafe konim?${NC}"
    echo "1. Database sade baraye projeha"
    echo "2. Feature version control"
    echo "3. Test automation"
    echo "4. Feature dastoor haye moshtarak"
    echo ""
    
    read -p "Entekhabe khod baraye feature badi ra vared konid (1-4): " feature_choice
    echo ""
    echo "Pishnahad shoma: $feature_choice"
    echo "Dar version badi ezafe khahad shod!"
    
    read -p "Press Enter to continue..."
    main_menu
}

# Function baraye darkhast feature jadid
request_feature() {
    clear
    echo -e "${BLUE}=== DARKHAST FEATURE JADID ===${NC}"
    echo ""
    
    echo "Dar inja mitavanid feature jadid e khod ra pishnahad dahid:"
    echo ""
    
    read -p "Name feature: " feature_name
    read -p "Tozihat (komak konande): " feature_desc
    
    echo ""
    echo -e "${GREEN}Darkhast shoma sabt shod!${NC}"
    echo "Feature: $feature_name"
    echo "Tozihat: $feature_desc"
    echo ""
    echo "Ba tashakor az pishnahad shoma!"
    
    # Sabt darkhast dar file
    echo "$(date) | $feature_name | $feature_desc" >> "feature_requests.txt"
    
    read -p "Press Enter to continue..."
    main_menu
}

# Shoroo e barname
clear
echo -e "${GREEN}"
echo "┌─────────────────────────────────────────┐"
echo "│                                         │"
echo "│  WELCOME TO PROGRESSIVE BARNAME!        │"
echo "│                                         │"
echo "│  Har marhale feature jadid ezafe mishavad │"
echo "│  Ba ham barname ra behtar mikonim!      │"
echo "│                                         │"
echo "└─────────────────────────────────────────┘"
echo -e "${NC}"
echo ""
echo "Barname dar 3 sanie shoroo mishavad..."
sleep 3

# Shoroo e menu asli
main_menu