#!/bin/bash

# Colors
PURPLE='\033[0;35m'
YELLOW='\033[0;93m'
CYAN_B='\033[1;96m'
LIGHT='\x1b[2m'
RESET='\033[0m'

PROMPT_TIMEOUT=15 # When user is prompted for input, skip after x seconds

#************************
# Update Everything
#************************
apt update
apt full-upgrade -y
snap refresh -y

#************************
# Basic Packages
#************************
debian_apps=(
  # Essentials
  'git'           # Version controll
  'neovim'        # Text editor
  'tmux'          # Term multiplexer
  'wget'          # Download files
  'zsh'           # prep for oh my zsh

  # CLI Power Basics
  'duf'           # Get info on mounted disks (better df)
  'htop'          # system task monitor
  'neofetch'      # quick system view
  'speedtest-cli' # speed testing ookala
  'net-tools'     # ifconfig etc

  # Basic Security Utilities
  'gnupg'         # PGP encryption, signing and verifying
  'rkhunter'      # Search / detect potential root kits
  'fail2ban'      # host intrusion detection
)

#************************
# Install the basics
#************************
# Prompt user to install all listed apps
echo -e "${CYAN_B}Would you like to install listed apps? (y/N)${RESET}\n"
read -t $PROMPT_TIMEOUT -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo -e "${PURPLE}Starting install...${RESET}"
  for app in ${debian_apps[@]}; do
    if hash "${app}" 2> /dev/null; then
      echo -e "${YELLOW}[Skipping]${LIGHT} ${app} is already installed${RESET}"
    elif hash flatpak 2> /dev/null && [[ ! -z $(echo $(flatpak list --columns=ref | grep $app)) ]]; then
      echo -e "${YELLOW}[Skipping]${LIGHT} ${app} is already installed via Flatpak${RESET}"
    else
      echo -e "${PURPLE}[Installing]${LIGHT} Downloading ${app}...${RESET}"
      sudo apt install ${app} --assume-yes
    fi
  done
fi

echo -e "${PURPLE}Finished installing / updating Debian packages.${RESET}"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

source ~/.zshrc
