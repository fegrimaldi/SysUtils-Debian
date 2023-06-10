#!/bin/bash

# Shell colors
RED='\e[0;31m'
YELLOW='\e[0;33m'
CYAN='\e[0;36m'
LIGHT_GRAY='\e[0;37m'
END_COLOR='\e[0m'

# Update OS and Install Red Hat Base Packages
printf "${YELLOW} Updating OS and Installing Base Packages.${END_COLOR}\n"
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt autoclean -y
sudo apt install zsh members tree fonts-powerline fonts-firacode net-tools nmap zip unzip -y

# Configure SSH Server: Regenerate Keys
printf "${YELLOW}Reconfiguring SSH Server and generating new keys.${END_COLOR}\n"
sudo rm -v /etc/ssh/ssh_host_*
sudo dpkg-reconfigure openssh-server


printf "${YELLOW}Generating SSH Keys for User: $USER.${END_COLOR}\n"
ssh-keygen

printf "${YELLOW}Creating devops group and set scripts directory.: $USER.${END_COLOR}\n"
# ! Test
sudo groupadd devops
sudo usermod -a -G devops sysadmin
sudo mkdir -p /usr/local/scripts
sudo chown root:devops -R /usr/local/scripts
sudo chmod g+w /usr/local/scripts


printf "${RED}It is recommend that you reboot the system now.${END_COLOR}\n"
printf "${Yellow}Remember to run ssh-keygen -R <hostname> on your workstation before connecting via ssh again.${END_COLOR}\n"