#!/bin/bash

# Shell colors
RED='\e[0;31m'
YELLOW='\e[0;33m'
CYAN='\e[0;36m'
LIGHT_GRAY='\e[0;37m'
END_COLOR='\e[0m'

# Download miniconda python installation script
# URL: https://docs.conda.io/en/latest/miniconda.html
# curl --insecure --proxy <proxy_address>:<port> -Lo Miniconda3-latest-Linux-x86_64.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
curl -Lo Miniconda3-latest-Linux-x86_64.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod +x ./Miniconda3-latest-Linux-x86_64.sh


printf "${CYAN}Installing Miniconda to /usr/local/miniconda3.${END_COLOR}\n"
sudo ./Miniconda3-latest-Linux-x86_64.sh -b -p /usr/local/miniconda3 && \

printf "{CYAN}Modifying permissions on /usr/local/miniconda3.${END_COLOR}\n"
sudo chown root:devops -R /usr/local/miniconda3 && \
sudo chmod g+w -R /usr/local/miniconda3 && \

if [ -w /usr/local/miniconda3 ]; then
    printf "${CYAN} Miniconda directory is writeable by current process. Proceeding...${END_COLOR}\n"
else
    printf "${RED}ERROR: ${YELLOW}Directory is NOT writeable by current process. Terminating.${END_COLOR}\n"
    exit 1
fi
printf "${CYAN}Activating Miniconda3.${END_COLOR}\n"
source /usr/local/miniconda3/bin/activate


printf "${CYAN}Initializing bash and zsh with conda.${END_COLOR}\n"
conda init zsh

conda init bash


printf "${CYAN}Updating Conda and Python.${END_COLOR}\n"
conda update conda -y

conda update python -y


# printf "${CYAN}Installing base python modules.${END_COLOR}\n"
# pip install -r python_base_reqs.txt


