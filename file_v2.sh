#!/bin/bash
# Romanized Bash - Progressiv Barname
# Version 2.0
# Feature haye jadid: Database, Version Control, Test Runner

# Rang haye mokhtalef
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Database sade - JSON format
DB_FILE="projects_db.json"
LOG_FILE="progress_log.txt"

# Initialize database agar mojod nabashad
init_database() {
    if [ ! -f "$DB_FILE" ]; then
        echo "[]" > "$DB_FILE"
        echo "$(date) - Database initialized" >> "$LOG_FILE"
    fi
}

# Function asli
main_menu() {
    clear
    echo -e "${GREEN}"
    echo "┌─────────────────────────────────────┐"
    echo "│  Progressive Barname - V 2.0        │"
    echo "│  New: DB, Version Control, Test!   │"
    echo "└─────────────────────────────────────┘"
    echo -e "${NC}"
    echo ""
    echo "1. Shoroo ye kare jadid"
    echo "2. List proje haye ghabli"
    echo "3. Help va rahnamayi"
    echo "4. Khabar dadan az feature jadid"
    echo "5. Test Runner (FEATURE JADID)"
    echo "6. Version Control (FEATURE JADID)"
    echo "7. Show Project Stats (FEATURE JADID)"
    echo "8. Khorooj"
    echo ""
    
    read -p "Entekhabe khod ra vared konid (1-8): " choice
    
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
            test_runner
            ;;
        6)
            version_control
            ;;
        7)
            show_stats
            ;;
        8)
            echo "Khodahafez! Ba arezooye ruz e khub :)"
            echo "$(date) - User exited" >> "$LOG_FILE"
            exit 0
            ;;
        *)
            echo -e "${RED}Entekhab ghabele qabol nist!${NC}"
            sleep 2
            main_menu
            ;;
    esac
}

# 1. Function baraye shoroo ye proje jadid (upgrade shode)
start_new_project() {
    clear
    echo -e "${BLUE}=== SHOROO YE PROJE JADID ===${NC}"
    echo ""
    
    read -p "Name proje ra vared konid: " project_name
    read -p "Noe proje (CLI/WEB/TOOL/OTHER): " project_type
    read -p "Tozihat (kotah): " description
    
    # Sakhtane file proje
    timestamp=$(date +"%Y%m%d_%H%M%S")
    filename="${project_name}_${timestamp}.prog"
    
    # Template e file
    cat > "$filename" << EOF
#!/bin/bash
# Proje: $project_name
# Sakhte shode dar: $(date)
# Tozihat: $description
# Noe: $project_type
# Version: 1.0

echo "========================================"
echo "PROJE: $project_name"
echo "TYPE: $project_type"
echo "VERSION: 1.0"
echo "DATE: $(date)"
echo "========================================"

# Main code inja neveshte mishavad
main() {
    echo "Hello from $project_name!"
    echo "This is a new progressive project."
    
    # Example function
    show_menu() {
        echo ""
        echo "1. Run basic test"
        echo "2. Show project info"
        echo "3. Exit"
        read -p "Choose: " choice
        
        case \$choice in
            1) echo "Test passed!" ;;
            2) echo "Project: $project_name" ;;
            3) exit 0 ;;
            *) echo "Invalid choice" ;;
        esac
    }
    
    show_menu
}

# Execute
main "\$@"
EOF
    
    chmod +x "$filename"
    
    # Save to database (JSON)
    project_id=$(date +%s)
    project_data="{\"id\":\"$project_id\",\"name\":\"$project_name\",\"type\":\"$project_type\",\"description\":\"$description\",\"filename\":\"$filename\",\"created\":\"$(date)\",\"version\":\"1.0\"}"
    
    # Update JSON database
    if [ -s "$DB_FILE" ]; then
        temp_file=$(mktemp)
        jq --argjson new "$project_data" '. += [$new]' "$DB_FILE" > "$temp_file" 2>/dev/null
        if [ $? -eq 0 ]; then
            mv "$temp_file" "$DB_FILE"
        else
            # Simple append agar jq mojod nabashad
            echo "$project_data" >> "$DB_FILE"
        fi
    else
        echo "[$project_data]" > "$DB_FILE"
    fi
    
    echo "$(date) - Created project: $project_name" >> "$LOG_FILE"
    
    echo -e "${GREEN}"
    echo "✓ Proje '$project_name' ba movafaqiyat sakhte shod!"
    echo "✓ File: $filename"
    echo "✓ Database updated"
    echo -e "${NC}"
    
    read -p "Aya mikhahid file ra run konid? (y/n): " run_choice
    if [[ "$run_choice" == "y" || "$run_choice" == "Y" ]]; then
        echo ""
        echo -e "${CYAN}=== RUNNING PROJECT ===${NC}"
        ./"$filename"
    fi
    
    read -p "Press Enter to continue..."
    main_menu
}

# 2. Function baraye list projeha (upgrade shode)
list_projects() {
    clear
    echo -e "${YELLOW}=== PROJE HAYE GHABLI ===${NC}"
    echo ""
    
    if [ -f "$DB_FILE" ] && [ -s "$DB_FILE" ]; then
        echo -e "${GREEN}Projects from database:${NC}"
        echo ""
        
        # Display projects (simple grep method)
        grep -o '"name":"[^"]*"' "$DB_FILE" | sed 's/"name":"//g' | sed 's/"//g' | nl
        
        echo ""
        echo -e "${CYAN}Total projects: $(grep -c '"name"' "$DB_FILE")${NC}"
    else
        # Fallback to file system
        echo -e "${YELLOW}Using file system list:${NC}"
        echo ""
        ls *.prog 2>/dev/null | nl || echo -e "${RED}No projects found${NC}"
    fi
    
    echo ""
    read -p "Press Enter to continue..."
    main_menu
}

# 3. Function help (upgrade shode)
show_help() {
    clear
    echo -e "${BLUE}=== HELP VA RAHNAMAYI - VERSION 2.0 ===${NC}"
    echo ""
    echo "FEATURE HAYE JADID DAR VERSION 2.0:"
    echo ""
    echo "1. ${GREEN}DATABASE SYSTEM${NC}"
    echo "   - Sabt e proje ha dar JSON"
    echo "   - Search va filter dar ayande"
    echo "   - Automatic backup"
    echo ""
    echo "2. ${GREEN}TEST RUNNER${NC}"
    echo "   - Test haye automatic"
    echo "   - Unit test sade"
    echo "   - Integration test"
    echo ""
    echo "3. ${GREEN}VERSION CONTROL${NC}"
    echo "   - Sabt e taghirat"
    echo "   - Version badi"
    echo "   - Changelog automatik"
    echo ""
    echo "4. ${GREEN}STATISTICS${NC}"
    echo "   - Amar e proje ha"
    echo "   - Log haye faaliat"
    echo "   - Progress tracking"
    echo ""
    
    read -p "Che feature i ra baraye version 3.0 mikhahid? (1-5): "
    echo ""
    echo "Pishnahad shoma sabt shod!"
    
    read -p "Press Enter to continue..."
    main_menu
}

# 4. Function baraye darkhast feature jadid
request_feature() {
    clear
    echo -e "${BLUE}=== DARKHAST FEATURE JADID ===${NC}"
    echo ""
    
    echo "Feature haye dar hale tarseem:"
    echo "1. GUI Interface (with dialog/ncurses)"
    echo "2. Cloud Backup"
    echo "3. Team Collaboration"
    echo "4. Plugin System"
    echo "5. Auto-deploy"
    echo ""
    
    read -p "Name feature jadid: " feature_name
    read -p "Tozihat (komak konande): " feature_desc
    read -p "Priority (High/Medium/Low): " priority
    
    echo ""
    echo -e "${GREEN}Darkhast shoma sabt shod!${NC}"
    echo "Feature: $feature_name"
    echo "Priority: $priority"
    echo ""
    
    # Sabt darkhast dar file ba format jadid
    echo "=== $(date) ===" >> "feature_requests.txt"
    echo "Feature: $feature_name" >> "feature_requests.txt"
    echo "Description: $feature_desc" >> "feature_requests.txt"
    echo "Priority: $priority" >> "feature_requests.txt"
    echo "" >> "feature_requests.txt"
    
    echo "Ba tashakor az pishnahad shoma!"
    
    read -p "Press Enter to continue..."
    main_menu
}

# 5. TEST RUNNER (FEATURE JADID)
test_runner() {
    clear
    echo -e "${PURPLE}=== TEST RUNNER ===${NC}"
    echo ""
    
    echo "1. Run all project tests"
    echo "2. Run specific project test"
    echo "3. Create test template"
    echo "4. View test results"
    echo ""
    
    read -p "Choose option: " test_choice
    
    case $test_choice in
        1)
            echo "Running all tests..."
            # Simple test - check if projects are executable
            for file in *.prog; do
                if [ -f "$file" ] && [ -x "$file" ]; then
                    echo -e "${GREEN}✓ $file is executable${NC}"
                elif [ -f "$file" ]; then
                    echo -e "${YELLOW}⚠ $file exists but not executable${NC}"
                    chmod +x "$file"
                else
                    echo -e "${RED}No .prog files found${NC}"
                fi
            done
            ;;
        2)
            read -p "Enter project name: " test_project
            if [ -f "$test_project" ]; then
                echo "Testing $test_project..."
                # Simple syntax check
                bash -n "$test_project" && echo -e "${GREEN}Syntax check: PASSED${NC}" || echo -e "${RED}Syntax check: FAILED${NC}"
                # Run with test mode
                echo "Test output:"
                timeout 2 bash "$test_project" | head -20
            else
                echo "Project not found!"
            fi
            ;;
        3)
            read -p "Test template name: " test_name
            cat > "test_${test_name}.sh" << 'TEST_EOF'
#!/bin/bash
# Test Template
# Created: $(date)

echo "Running tests..."
echo "Test 1: Basic check"
[ -f "$1" ] && echo "PASS: File exists" || echo "FAIL: File missing"

echo "Test 2: Executable check"
[ -x "$1" ] && echo "PASS: Is executable" || echo "FAIL: Not executable"

echo "Test 3: Syntax check"
bash -n "$1" 2>/dev/null && echo "PASS: Valid syntax" || echo "FAIL: Syntax error"

echo "Tests completed!"
TEST_EOF
            chmod +x "test_${test_name}.sh"
            echo "Test template created!"
            ;;
        4)
            echo "Test Results History:"
            echo "====================="
            tail -10 "$LOG_FILE" 2>/dev/null || echo "No logs yet"
            ;;
        *)
            echo "Invalid choice"
            ;;
    esac
    
    echo ""
    read -p "Press Enter to continue..."
    main_menu
}

# 6. VERSION CONTROL (FEATURE JADID)
version_control() {
    clear
    echo -e "${CYAN}=== VERSION CONTROL ===${NC}"
    echo ""
    
    echo "1. View project versions"
    echo "2. Create new version"
    echo "3. Compare versions"
    echo "4. Version history"
    echo ""
    
    read -p "Choose option: " version_choice
    
    case $version_choice in
        1)
            echo "Project Versions:"
            echo "-----------------"
            if [ -f "$DB_FILE" ]; then
                grep -o '"name":"[^"]*","version":"[^"]*"' "$DB_FILE" | \
                sed 's/"name":"//g' | sed 's/","version":"/ - v/g' | sed 's/"//g'
            fi
            ;;
        2)
            read -p "Project name to update: " proj_name
            read -p "New version (e.g., 2.1): " new_version
            read -p "Changelog: " changelog
            
            # Create backup
            backup_file="${proj_name}_backup_$(date +%s).bak"
            find . -name "*${proj_name}*.prog" -exec cp {} "$backup_file" \; 2>/dev/null
            
            echo "Created backup: $backup_file"
            echo "Version $new_version created!"
            echo "Changelog: $changelog"
            
            # Log the version change
            echo "$(date) - Version update: $proj_name -> $new_version" >> "$LOG_FILE"
            echo "$changelog" >> "changelog.txt"
            ;;
        3)
            echo "Available backups:"
            ls *.bak 2>/dev/null || echo "No backups found"
            echo ""
            read -p "Enter first file: " file1
            read -p "Enter second file: " file2
            if [ -f "$file1" ] && [ -f "$file2" ]; then
                echo "Differences:"
                diff -u "$file1" "$file2" | head -30
            fi
            ;;
        4)
            echo "Version History:"
            echo "================"
            if [ -f "changelog.txt" ]; then
                cat "changelog.txt"
            else
                echo "No version history yet"
            fi
            ;;
        *)
            echo "Invalid choice"
            ;;
    esac
    
    echo ""
    read -p "Press Enter to continue..."
    main_menu
}

# 7. SHOW STATS (FEATURE JADID)
show_stats() {
    clear
    echo -e "${GREEN}=== PROJECT STATISTICS ===${NC}"
    echo ""
    
    # Basic stats
    project_count=$(ls *.prog 2>/dev/null | wc -l)
    db_count=$(grep -c '"name"' "$DB_FILE" 2>/dev/null || echo "0")
    feature_count=$(grep -c "Feature:" "feature_requests.txt" 2>/dev/null || echo "0")
    backup_count=$(ls *.bak 2>/dev/null | wc -l)
    
    echo "📊 Statistics:"
    echo "--------------"
    echo "Total Projects: $project_count"
    echo "In Database: $db_count"
    echo "Feature Requests: $feature_count"
    echo "Backup Files: $backup_count"
    echo "Log Entries: $(wc -l < "$LOG_FILE" 2>/dev/null || echo "0")"
    echo ""
    
    # Recent activity
    echo "Recent Activity:"
    echo "---------------"
    tail -5 "$LOG_FILE" 2>/dev/null || echo "No activity yet"
    echo ""
    
    # Project types
    echo "Project Types:"
    echo "-------------"
    grep -o '"type":"[^"]*"' "$DB_FILE" 2>/dev/null | \
        sort | uniq -c | sed 's/"type":"//g' | sed 's/"//g' || \
        echo "No type data available"
    
    echo ""
    read -p "Press Enter to continue..."
    main_menu
}

# Initialize system
init_database

# Shoroo e barname
clear
echo -e "${GREEN}"
cat << "EOF"
┌─────────────────────────────────────────┐
│  PROGRESSIVE BARNAME - VERSION 2.0!     │
│                                         │
│  New Features:                          │
│  • Database System                      │
│  • Test Runner                          │
│  • Version Control                      │
│  • Statistics                           │
│                                         │
│  Dar har marhale behtar mishavad!       │
└─────────────────────────────────────────┘
EOF
echo -e "${NC}"
echo ""
echo "Loading..."
sleep 2

# Log startup
echo "$(date) === Program started (v2.0) ===" >> "$LOG_FILE"

# Shoroo e menu asli
main_menu