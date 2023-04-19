#!/bin/bash

# Shell colors
RED='\e[0;31m'
YELLOW='\e[0;33m'
CYAN='\e[0;36m'
LIGHT_GRAY='\e[0;37m'
END_COLOR='\e[0m'

# Update OS and Install Red Hat Base Packages
printf "${YELLOW} Updating OS and Installing Base Packages.${END_COLOR}\n"
sudo apt-get update && sudo apt-get upgrade -y && sudo apt autoremove -y && \
sudo apt-get install zsh members tree fonts-powerline fonts-firacode net-tools -y && \

# Configure SSH Server: Regenerate Keys
printf "${YELLOW}Reconfiguring SSH Server and generating new keys.${END_COLOR}\n"
sudo rm -v /etc/ssh/ssh_host_* && \
sudo dpkg-reconfigure openssh-server && \


printf "${YELLOW}Generating SSH Keys for User: $USER.${END_COLOR}\n"
ssh-keygen


printf "${RED}It is recommend that you reboot the system now.${END_COLOR}\n"
printf "${Yellow}Remember to run ssh-keygen -R <hostname> on your workstation before connecting via ssh again.${END_COLOR}\n"