#!/data/data/com.termux/files/usr/bin/bash

# Terminal colors (fixed for better compatibility)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
NC='\033[0m'

# Main configuration
VERSION="3.0.0"
CONFIG_DIR="$HOME/.termanager"
LOG_FILE="$CONFIG_DIR/termanager.log"
BACKUP_DIR="$HOME/TermuxBackups"
TOOLS_LIST="$CONFIG_DIR/installed_tools.txt"
UPDATE_FLAG="$CONFIG_DIR/update_available.flag"

# Function to log messages
log_message() {
    local msg="$1"
    local color="$2"
    echo -e "${color}[$(date '+%H:%M:%S')] ${msg}${NC}" | tee -a "$LOG_FILE"
}

# Function to check internet
check_internet() {
    if ping -c 1 google.com >/dev/null 2>&1; then
        return 0
    else
        log_message "No internet connection!" "$RED"
        return 1
    fi
}

# Function to show header
show_header() {
    clear
    echo -e "${PURPLE}╔════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║      T E R M A N A G E R   v${VERSION}              ║${NC}"
    echo -e "${PURPLE}╚════════════════════════════════════════════════╝${NC}"
    echo ""
}

# Initialize configuration
init_setup() {
    if [ ! -d "$CONFIG_DIR" ]; then
        mkdir -p "$CONFIG_DIR"
        echo "# Termanager Configuration" > "$CONFIG_DIR/config.cfg"
        echo "auto_update=true" >> "$CONFIG_DIR/config.cfg"
        echo "backup_count=5" >> "$CONFIG_DIR/config.cfg"
        log_message "Configuration initialized" "$GREEN"
    fi
    
    # Create backup directory
    mkdir -p "$BACKUP_DIR"
}

# Function to check and install basic dependencies
install_basics() {
    log_message "Checking basic packages..." "$YELLOW"
    
    local basic_packages=("git" "wget" "curl" "python" "python-pip" "nano" "tar" "gzip")
    
    for pkg in "${basic_packages[@]}"; do
        if ! command -v $pkg >/dev/null 2>&1; then
            log_message "Installing $pkg..." "$BLUE"
            pkg install -y $pkg 2>/dev/null
        fi
    done
}

# Main menu function
show_main_menu() {
    show_header
    echo -e "${BOLD}Select an option:${NC}"
    echo -e "${GREEN}[1]${NC} Update & Upgrade Packages"
    echo -e "${GREEN}[2]${NC} System Backup"
    echo -e "${GREEN}[3]${NC} Install Security Tools"
    echo -e "${GREEN}[4]${NC} Install Dev Tools"
    echo -e "${GREEN}[5]${NC} System Cleaner"
    echo -e "${GREEN}[6]${NC} System Monitor"
    echo -e "${GREEN}[7]${NC} Performance Booster"
    echo -e "${GREEN}[8]${NC} Custom Scripts"
    echo -e "${GREEN}[9]${NC} Settings"
    echo -e "${GREEN}[0]${NC} Exit"
    echo ""
    echo -e "${PURPLE}════════════════════════════════════════════════${NC}"
}

# Option 1: Update all packages
update_system() {
    show_header
    log_message "Starting system update..." "$CYAN"
    
    echo -e "${YELLOW}Step 1: Updating package list...${NC}"
    pkg update -y
    
    echo -e "${YELLOW}Step 2: Upgrading packages...${NC}"
    pkg upgrade -y
    
    echo -e "${YELLOW}Step 3: Upgrading pip packages...${NC}"
    if command -v pip >/dev/null; then
        pip install --upgrade pip
        pip list --outdated | cut -d ' ' -f 1 | xargs -n1 pip install --upgrade 2>/dev/null
    fi
    
    log_message "System update completed!" "$GREEN"
    sleep 2
}

# Option 2: Backup system
backup_system() {
    show_header
    log_message "Creating system backup..." "$BLUE"
    
    local timestamp=$(date +"%Y%m%d_%H%M%S")
    local backup_file="termux_backup_${timestamp}.tar.gz"
    
    echo -e "${YELLOW}What do you want to backup?${NC}"
    echo "1) Full backup (recommended)"
    echo "2) Config files only"
    echo "3) Custom selection"
    echo ""
    read -p "Choice [1-3]: " backup_choice
    
    case $backup_choice in
        1)
            # Full backup
            tar -czf "$BACKUP_DIR/$backup_file" \
                $HOME/.termux \
                $HOME/.config \
                $HOME/.bash* \
                $HOME/.zsh* \
                $HOME/.gitconfig \
                $HOME/.ssh \
                $HOME/.vim* \
                $HOME/.npm \
                $HOME/.pip 2>/dev/null
            ;;
        2)
            # Config only
            tar -czf "$BACKUP_DIR/$backup_file" \
                $HOME/.termux \
                $HOME/.bashrc \
                $HOME/.gitconfig \
                $HOME/.ssh/config 2>/dev/null
            ;;
        3)
            echo -e "${YELLOW}Enter directory/files (space separated):${NC}"
            read -p "> " custom_files
            tar -czf "$BACKUP_DIR/$backup_file" $custom_files 2>/dev/null
            ;;
        *)
            tar -czf "$BACKUP_DIR/$backup_file" $HOME/.termux $HOME/.bashrc 2>/dev/null
            ;;
    esac
    
    if [ -f "$BACKUP_DIR/$backup_file" ]; then
        local size=$(du -h "$BACKUP_DIR/$backup_file" | cut -f1)
        log_message "Backup created: ${backup_file} (${size})" "$GREEN"
    else
        log_message "Backup failed!" "$RED"
    fi
    
    # Clean old backups (keep only 5)
    local backup_count=$(ls -1 $BACKUP_DIR/*.tar.gz 2>/dev/null | wc -l)
    if [ $backup_count -gt 5 ]; then
        ls -t $BACKUP_DIR/*.tar.gz | tail -n +6 | xargs rm -f
        log_message "Cleaned old backups" "$YELLOW"
    fi
    
    sleep 3
}

# Option 3: Install security tools
install_security_tools() {
    show_header
    log_message "Security Tools Installer" "$PURPLE"
    
    echo -e "${YELLOW}Select tools to install:${NC}"
    echo "1) Nmap (Network scanner)"
    echo "2) Hydra (Password cracker)"
    echo "3) SQLMap (SQL injection)"
    echo "4) Aircrack-ng (WiFi security)"
    echo "5) John The Ripper"
    echo "6) All tools"
    echo ""
    read -p "Choice [1-6]: " tool_choice
    
    case $tool_choice in
        1) pkg install -y nmap && log_message "Nmap installed" "$GREEN" ;;
        2) pkg install -y hydra && log_message "Hydra installed" "$GREEN" ;;
        3) 
            pkg install -y python git
            git clone https://github.com/sqlmapproject/sqlmap.git $HOME/sqlmap
            log_message "SQLMap cloned to ~/sqlmap" "$CYAN"
            ;;
        4) pkg install -y aircrack-ng && log_message "Aircrack-ng installed" "$GREEN" ;;
        5) pkg install -y john && log_message "John installed" "$GREEN" ;;
        6)
            pkg install -y nmap hydra aircrack-ng john
            git clone https://github.com/sqlmapproject/sqlmap.git $HOME/sqlmap
            log_message "All security tools installed" "$GREEN"
            ;;
    esac
    
    # Add to installed tools list
    echo "$(date): Installed security tool" >> "$TOOLS_LIST"
    sleep 2
}

# Option 4: Install dev tools
install_dev_tools() {
    show_header
    log_message "Developer Tools Installer" "$CYAN"
    
    echo -e "${YELLOW}Select category:${NC}"
    echo "1) Programming Languages"
    echo "2) Code Editors"
    echo "3) Version Control"
    echo "4) Web Development"
    echo ""
    read -p "Choice [1-4]: " dev_choice
    
    case $dev_choice in
        1)
            echo "Installing languages..."
            pkg install -y python nodejs openjdk-17 php ruby
            log_message "Programming languages installed" "$GREEN"
            ;;
        2)
            echo "Installing editors..."
            pkg install -y vim neovim nano emacs
            log_message "Code editors installed" "$GREEN"
            ;;
        3)
            echo "Installing version control..."
            pkg install -y git gh subversion
            log_message "Version control tools installed" "$GREEN"
            ;;
        4)
            echo "Installing web tools..."
            pkg install -y curl wget httpie apache2 nginx
            pip install flask django
            log_message "Web tools installed" "$GREEN"
            ;;
    esac
    sleep 2
}

# Option 5: System cleaner
clean_system() {
    show_header
    log_message "System Cleaner" "$YELLOW"
    
    echo -e "${RED}Warning: This will remove temporary files${NC}"
    echo ""
    echo "1) Clean package cache"
    echo "2) Clean pip cache"
    echo "3) Clean npm cache"
    echo "4) Clean all caches"
    echo ""
    read -p "Choice [1-4]: " clean_choice
    
    case $clean_choice in
        1)
            pkg clean
            pkg autoclean
            log_message "Package cache cleaned" "$GREEN"
            ;;
        2)
            pip cache purge 2>/dev/null
            log_message "Pip cache cleaned" "$GREEN"
            ;;
        3)
            if command -v npm >/dev/null; then
                npm cache clean --force
                log_message "NPM cache cleaned" "$GREEN"
            fi
            ;;
        4)
            pkg clean
            pkg autoclean
            pip cache purge 2>/dev/null
            if command -v npm >/dev/null; then
                npm cache clean --force
            fi
            rm -rf $HOME/.cache/*
            log_message "All caches cleaned" "$GREEN"
            ;;
    esac
    
    # Show freed space
    df -h $HOME | tail -1
    sleep 3
}

# Option 6: System monitor
system_monitor() {
    show_header
    log_message "System Monitor" "$BLUE"
    
    echo -e "${CYAN}════════════════════════════════════════════════${NC}"
    echo -e "${BOLD}System Information:${NC}"
    echo -e "${GREEN}OS:${NC} $(uname -o)"
    echo -e "${GREEN}Kernel:${NC} $(uname -r)"
    echo -e "${GREEN}Arch:${NC} $(uname -m)"
    echo ""
    
    echo -e "${BOLD}Storage Usage:${NC}"
    df -h $HOME | grep -v tmpfs
    echo ""
    
    echo -e "${BOLD}Memory Usage:${NC}"
    free -h
    echo ""
    
    echo -e "${BOLD}Top Processes:${NC}"
    ps aux --sort=-%cpu | head -5
    echo ""
    
    echo -e "${CYAN}════════════════════════════════════════════════${NC}"
    echo ""
    read -p "Press Enter to continue..."
}

# Option 7: Performance booster
boost_performance() {
    show_header
    log_message "Performance Booster" "$PURPLE"
    
    echo "1) Create swap file (512MB)"
    echo "2) Optimize bashrc"
    echo "3) Install zsh (faster shell)"
    echo "4) All optimizations"
    echo ""
    read -p "Choice [1-4]: " boost_choice
    
    case $boost_choice in
        1)
            if [ ! -f $HOME/.swapfile ]; then
                dd if=/dev/zero of=$HOME/.swapfile bs=1M count=512
                mkswap $HOME/.swapfile
                swapon $HOME/.swapfile
                log_message "Swap file created (512MB)" "$GREEN"
            else
                log_message "Swap file already exists" "$YELLOW"
            fi
            ;;
        2)
            if ! grep -q "# Termanager Aliases" $HOME/.bashrc; then
                echo -e "\n# Termanager Aliases" >> $HOME/.bashrc
                echo "alias update='pkg update && pkg upgrade'" >> $HOME/.bashrc
                echo "alias clean='pkg clean && pkg autoclean'" >> $HOME/.bashrc
                echo "alias ll='ls -la'" >> $HOME/.bashrc
                echo "alias ..='cd ..'" >> $HOME/.bashrc
                log_message "Bashrc optimized" "$GREEN"
            fi
            ;;
        3)
            pkg install -y zsh
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
            log_message "Zsh installed" "$GREEN"
            ;;
        4)
            # All optimizations
            if [ ! -f $HOME/.swapfile ]; then
                dd if=/dev/zero of=$HOME/.swapfile bs=1M count=512
                mkswap $HOME/.swapfile
                swapon $HOME/.swapfile
            fi
            
            pkg install -y zsh
            echo "alias update='pkg update && pkg upgrade'" >> $HOME/.bashrc
            log_message "All optimizations applied" "$GREEN"
            ;;
    esac
    sleep 2
}

# Option 8: Custom scripts
custom_scripts() {
    show_header
    log_message "Custom Scripts Manager" "$CYAN"
    
    echo "1) Run custom script"
    echo "2) Download script from URL"
    echo "3) Create new script"
    echo ""
    read -p "Choice [1-3]: " script_choice
    
    case $script_choice in
        1)
            read -p "Enter script path: " script_path
            if [ -f "$script_path" ]; then
                bash "$script_path"
            else
                log_message "File not found!" "$RED"
            fi
            ;;
        2)
            read -p "Enter script URL: " script_url
            read -p "Save as (filename): " script_name
            wget -O "$HOME/$script_name" "$script_url"
            chmod +x "$HOME/$script_name"
            log_message "Script downloaded: ~/$script_name" "$GREEN"
            ;;
        3)
            read -p "Script name: " new_script
            echo "#!/bin/bash" > "$HOME/$new_script"
            echo "# Created by Termanager" >> "$HOME/$new_script"
            chmod +x "$HOME/$new_script"
            nano "$HOME/$new_script"
            log_message "Script created: ~/$new_script" "$GREEN"
            ;;
    esac
    sleep 2
}

# Option 9: Settings
show_settings() {
    show_header
    log_message "Settings" "$BLUE"
    
    echo "1) Change backup location"
    echo "2) Enable/disable auto-update"
    echo "3) View logs"
    echo "4) Reset configuration"
    echo ""
    read -p "Choice [1-4]: " settings_choice
    
    case $settings_choice in
        1)
            read -p "New backup path: " new_backup_path
            if [ -d "$new_backup_path" ]; then
                BACKUP_DIR="$new_backup_path"
                echo "backup_dir=$new_backup_path" > "$CONFIG_DIR/backup.cfg"
                log_message "Backup location changed" "$GREEN"
            fi
            ;;
        2)
            if [ -f "$CONFIG_DIR/config.cfg" ]; then
                if grep -q "auto_update=true" "$CONFIG_DIR/config.cfg"; then
                    sed -i 's/auto_update=true/auto_update=false/' "$CONFIG_DIR/config.cfg"
                    log_message "Auto-update disabled" "$YELLOW"
                else
                    sed -i 's/auto_update=false/auto_update=true/' "$CONFIG_DIR/config.cfg"
                    log_message "Auto-update enabled" "$GREEN"
                fi
            fi
            ;;
        3)
            if [ -f "$LOG_FILE" ]; then
                echo -e "${CYAN}════════════════ LOG FILE ════════════════${NC}"
                tail -20 "$LOG_FILE"
                echo -e "${CYAN}══════════════════════════════════════════${NC}"
                echo ""
                read -p "Press Enter to continue..."
            else
                log_message "No log file found" "$YELLOW"
            fi
            ;;
        4)
            read -p "Are you sure? (y/n): " confirm_reset
            if [ "$confirm_reset" = "y" ]; then
                rm -rf "$CONFIG_DIR"
                log_message "Configuration reset" "$GREEN"
            fi
            ;;
    esac
    sleep 2
}

# Check for updates
check_for_updates() {
    if [ ! -f "$UPDATE_FLAG" ] || [ $(find "$UPDATE_FLAG" -mtime +1) ]; then
        log_message "Checking for updates..." "$YELLOW"
        
        # Simulated update check
        local latest_version="3.0.0"
        
        if [ "$latest_version" != "$VERSION" ]; then
            echo -e "${GREEN}Update available!${NC}"
            echo "Current: $VERSION"
            echo "Latest: $latest_version"
            read -p "Update now? (y/n): " update_choice
            
            if [ "$update_choice" = "y" ]; then
                log_message "Updating Termanager..." "$CYAN"
                # Update logic here
                touch "$UPDATE_FLAG"
            fi
        fi
    fi
}

# Main function
main() {
    # Initial setup
    init_setup
    install_basics
    
    # Check for updates
    check_for_updates
    
    # Main loop
    while true; do
        show_main_menu
        read -p "Enter choice [0-9]: " user_choice
        
        case $user_choice in
            1) update_system ;;
            2) backup_system ;;
            3) install_security_tools ;;
            4) install_dev_tools ;;
            5) clean_system ;;
            6) system_monitor ;;
            7) boost_performance ;;
            8) custom_scripts ;;
            9) show_settings ;;
            0)
                show_header
                echo -e "${GREEN}Thank you for using Termanager!${NC}"
                echo ""
                echo -e "${CYAN}Next time, run:${NC}"
                echo "bash ~/termanager.sh"
                echo "or"
                echo "termanager"
                echo ""
                exit 0
                ;;
            *)
                log_message "Invalid choice! Try again." "$RED"
                sleep 1
                ;;
        esac
    done
}

# Run main function
main
