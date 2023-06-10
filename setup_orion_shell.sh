#/bin/bash

# Shell colors
RED='\e[0;31m'
YELLOW='\e[0;33m'
CYAN='\e[0;36m'
LIGHT_GRAY='\e[0;37m'
END_COLOR='\e[0m'

# Test if OS is Debian based (Debian, Ubuntu, etc.). Exits if not.
if [ -f /etc/debian_version ] ; then
    printf "${CYAN}Discovered Debian Based OS. Proceeding...${END_COLOR}\n"
else
    printf "${RED}OS is not Debian Based. Terminating.${END_COLOR}\n"
    exit 1
fi

# Define Variables
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# Update the System and install Orion Shell required fonts.
# Power Line Fonts URL: https://github.com/powerline/fonts
# Fira Code Fonts URL: https://github.com/tonsky/FiraCode
# sudo apt-get update
# sudo apt-get install fonts-powerline fonts-firacode -y

# Install oh-my-zsh
# URL: https://github.com/ohmyzsh/ohmyzsh
# If you are behind a proxy, uncomment the curl command commented out below, change your proxy 
# server, and comment out the curl command that follows
# curl --insecure --proxy <proxy_address>:<port> -Lo install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh && \
curl -Lo install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
sh install.sh --unattended
rm -rf install.sh

# Install Spaceship Prompt
# URL: https://github.com/denysdovhan/spaceship-prompt
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="spaceship"/g' ~/.zshrc

# Install zsh-syntax-highlighting plugin
# URL: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# Zsh Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Base configuration of the the Orion Shell .zshrc
sed -i 's/plugins=(git)/plugins=(git colorize colored-man-pages python zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc
sed -i 's/# alias zshconfig="mate ~\/.zshrc"/alias zshconfig="vim ~\/.zshrc"/g' ~/.zshrc
sed -i 's/# ENABLE_CORRECTION="true"/ENABLE_CORRECTION="true"/g' ~/.zshrc
sed -i 's/# COMPLETION_WAITING_DOTS="true"/COMPLETION_WAITING_DOTS="true"/g' ~/.zshrc
echo ZSH_COLORIZE_STYLE=\"solarized-dark\" >> ~/.zshrc
echo alias grep-fc="\"grep -vE '^$|^#'\"" >> ~/.zshrc
echo alias view-syslog=\"sudo less /var/log/syslog\" >> ~/.zshrc
echo alias vimconfig="vim ~/.vimrc"
echo export EDITOR=vim >> ~/.zshrc

# Install plug-vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Changes default shell to zsh
printf "${CYAN}Changing the default shell to: ${YELLOW}/usr/bin/zsh${CYAN}\n"
chsh -s /usr/bin/zsh
printf "Congratulations! Your Orion Shell Environment is now installed.\n"
printf "Install miniconda python by running ${YELLOW}./Miniconda3-latest-Linux-x86_64.sh.\n"
printf "Log out and log back in to activate the shell.${END_COLOR}\n"
