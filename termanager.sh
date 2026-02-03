#!/data/data/com.termux/files/usr/bin/bash

# Rang haye terminal
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# Config haye asli
VERSION="2.1.0"
CONFIG_DIR="$HOME/.termanager"
LOG_FILE="$CONFIG_DIR/termanager.log"
BACKUP_DIR="$HOME/termux_backups"
TOOLS_LIST="$CONFIG_DIR/tools_installed.txt"

# Tabe haye helper
log() {
    echo -e "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
    echo -e "$2$1${NC}"
}

check_root() {
    if [ "$(whoami)" == "root" ]; then
        log "Warning: Root detected, might cause issues" "$YELLOW"
    fi
}

init_config() {
    if [ ! -d "$CONFIG_DIR" ]; then
        mkdir -p "$CONFIG_DIR"
        echo "# List of installed tools" > "$TOOLS_LIST"
        log "Config directory created" "$GREEN"
    fi
}

check_dependencies() {
    local basic_packages=("git" "wget" "curl" "python" "python-pip")
    local missing_pkgs=()
    
    for pkg in "${basic_packages[@]}"; do
        if ! pkg list-installed | grep -q "$pkg"; then
            missing_pkgs+=("$pkg")
        fi
    done
    
    if [ ${#missing_pkgs[@]} -gt 0 ]; then
        log "Installing basic packages..." "$YELLOW"
        pkg update -y && pkg upgrade -y
        for pkg in "${missing_pkgs[@]}"; do
            pkg install -y "$pkg" && log "Installed: $pkg" "$GREEN"
        done
    fi
}

show_menu() {
    clear
    echo -e "${PURPLE}══════════════════════════════════════════════${NC}"
    echo -e "${CYAN}     TERMANAGER v$VERSION - Termux Manager${NC}"
    echo -e "${PURPLE}══════════════════════════════════════════════${NC}"
    echo -e "${GREEN}1.${NC} Upgrade all packages"
    echo -e "${GREEN}2.${NC} Create backup"
    echo -e "${GREEN}3.${NC} Install hacking tools"
    echo -e "${GREEN}4.${NC} Install programming tools"
    echo -e "${GREEN}5.${NC} Clean system"
    echo -e "${GREEN}6.${NC} Show system info"
    echo -e "${GREEN}7.${NC} Optimize performance"
    echo -e "${GREEN}8.${NC} Update Termanager"
    echo -e "${GREEN}9.${NC} Exit"
    echo -e "${PURPLE}══════════════════════════════════════════════${NC}"
}

upgrade_all() {
    log "Starting full upgrade..." "$BLUE"
    
    pkg update && pkg upgrade -y
    pip install --upgrade pip 2>/dev/null
    if command -v npm &> /dev/null; then
        npm update -g
    fi
    
    log "All packages upgraded successfully!" "$GREEN"
}

create_backup() {
    log "Creating Termux backup..." "$YELLOW"
    
    if [ ! -d "$BACKUP_DIR" ]; then
        mkdir -p "$BACKUP_DIR"
    fi
    
    local backup_name="backup_$(date +%Y%m%d_%H%M%S).tar.gz"
    tar -czf "$BACKUP_DIR/$backup_name" \
        $HOME/.termux \
        $HOME/.config \
        $HOME/.bashrc \
        $HOME/.zshrc \
        $HOME/.gitconfig \
        $HOME/.ssh 2>/dev/null
    
    if [ $? -eq 0 ]; then
        log "Backup created: $backup_name" "$GREEN"
        log "Location: $BACKUP_DIR" "$CYAN"
    else
        log "Backup failed!" "$RED"
    fi
}

install_hacking_tools() {
    local tools=("nmap" "hydra" "sqlmap" "aircrack-ng" "john" "hashcat")
    
    log "Installing security tools..." "$PURPLE"
    
    pkg update
    for tool in "${tools[@]}"; do
        log "Installing $tool..." "$YELLOW"
        pkg install -y "$tool" 2>/dev/null
        if [ $? -eq 0 ]; then
            echo "$tool" >> "$TOOLS_LIST"
            log "✓ $tool installed" "$GREEN"
        else
            log "✗ Failed to install $tool" "$RED"
        fi
    done
    
    # Install sqlmap from git (better version)
    git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git $HOME/sqlmap-dev
    log "SQLMap cloned to $HOME/sqlmap-dev" "$CYAN"
}

install_programming() {
    local langs=("nodejs" "openjdk-17" "php" "ruby" "golang")
    
    log "Installing programming languages..." "$BLUE"
    
    for lang in "${langs[@]}"; do
        pkg install -y "$lang" && log "Installed: $lang" "$GREEN"
    done
    
    # Install code editors
    pkg install -y vim neovim nano
    log "Code editors installed" "$CYAN"
}

clean_system() {
    log "Cleaning system..." "$YELLOW"
    
    pkg clean
    pkg autoclean
    rm -rf $HOME/.cache/*
    
    if command -v pip &> /dev/null; then
        pip cache purge
    fi
    
    log "System cleaned!" "$GREEN"
}

system_info() {
    clear
    echo -e "${CYAN}══════════════════════════════════════════════${NC}"
    echo -e "${PURPLE}           SYSTEM INFORMATION${NC}"
    echo -e "${CYAN}══════════════════════════════════════════════${NC}"
    echo -e "${GREEN}OS:${NC} $(uname -o)"
    echo -e "${GREEN}Kernel:${NC} $(uname -r)"
    echo -e "${GREEN}Architecture:${NC} $(uname -m)"
    echo -e "${GREEN}Storage:${NC}"
    df -h $HOME | tail -1
    echo -e "${GREEN}Memory:${NC}"
    free -h | tail -1
    echo -e "${CYAN}══════════════════════════════════════════════${NC}"
}

optimize_performance() {
    log "Optimizing Termux performance..." "$PURPLE"
    
    # Create swap if doesn't exist
    if [ ! -f $HOME/.swapfile ]; then
        dd if=/dev/zero of=$HOME/.swapfile bs=1M count=512
        mkswap $HOME/.swapfile
        swapon $HOME/.swapfile
        log "512MB swap file created" "$GREEN"
    fi
    
    # Optimize bashrc
    if ! grep -q "TERMUX_PERFORMANCE" $HOME/.bashrc; then
        echo -e "\n# TERMUX_PERFORMANCE" >> $HOME/.bashrc
        echo "alias ls='ls --color=auto'" >> $HOME/.bashrc
        echo "alias ll='ls -la'" >> $HOME/.bashrc
        echo "alias update='pkg update && pkg upgrade'" >> $HOME/.bashrc
        log "Bashrc optimized" "$CYAN"
    fi
    
    log "Performance optimizations applied!" "$GREEN"
}

update_self() {
    log "Checking for updates..." "$BLUE"
    
    if [ ! -d $HOME/.termanager_update ]; then
        git clone https://github.com/termux-manager/termanager.git $HOME/.termanager_update 2>/dev/null
    else
        cd $HOME/.termanager_update
        git pull origin main 2>/dev/null
    fi
    
    if [ -f $HOME/.termanager_update/termanager.sh ]; then
        cp $HOME/.termanager_update/termanager.sh $0
        chmod +x $0
        log "Termanager updated successfully!" "$GREEN"
        log "Please restart the script" "$YELLOW"
        exit 0
    else
        log "Update failed!" "$RED"
    fi
}

main() {
    check_root
    init_config
    check_dependencies
    
    while true; do
        show_menu
        read -p "Enter your choice (1-9): " choice
        
        case $choice in
            1) upgrade_all ;;
            2) create_backup ;;
            3) install_hacking_tools ;;
            4) install_programming ;;
            5) clean_system ;;
            6) system_info ;;
            7) optimize_performance ;;
            8) update_self ;;
            9) 
                log "Goodbye! Exiting..." "$CYAN"
                exit 0
                ;;
            *)
                log "Invalid choice! Try again." "$RED"
                ;;
        esac
        
        echo -e "\n${YELLOW}Press Enter to continue...${NC}"
        read
    done
}

# Run main function
main
