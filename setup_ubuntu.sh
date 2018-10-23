#!/bin/bash

if [ "$EUID" -eq 0 ]
    then echo "DO NOT RUN IN SUDO!"
    exit
fi

echo "Updating..."
sudo apt -y update

echo "Installing common packages..."
sudo apt -y --ignore-missing install vim-gtk3 zsh tmux git gitk git-gui meld cmake htop tree xclip sysstat speedcrunch ctags inkscape gnome-tweak-tool gparted filezilla ack sshfs xsel ibus-cangjie guvcview flameshot tig

echo "Installing google chrome..."
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list

sudo apt -y update
sudo apt -y install google-chrome-stable

echo "Changing default shell to zsh..."
chsh -s /bin/zsh

echo "Grabbing customizations from github.com/rcywongaa/customizations.git"
#git init
#git remote add origin https://github.com/rcywongaa/customizations.git
#git pull origin master
git clone --recurse-submodules https://github.com/rcywongaa/config.git
cd config

ln -s "$(pwd)/.vimrc" ~/.vimrc
ln -s "$(pwd)/.zshrc" ~/.zshrc
ln -s "$(pwd)/.tmux.conf" ~/.tmux.conf

echo "Cloning fzf..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

echo "Cloning Vundle..."
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "Installing vim plugins..."
vim +PluginInstall +qall

echo "Cloning tpm..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Installing tpm plugins..."
# Taken from https://github.com/tmux-plugins/tpm/issues/6
# install the plugins
~/.tmux/plugins/tpm/scripts/install_plugins.sh

# http://bernaerts.dyndns.org/linux/76-gnome/345-gnome-shell-install-remove-extension-command-line-script#h2-all-in-one-installation-removal-script
./gnomeshell-extension-manage --version 'latest' --install --extension-id 779 --user # clipboard indicator
./gnomeshell-extension-manage --version 'latest' --install --extension-id 10 --user # windowNavigator
./gnomeshell-extension-manage --version 'latest' --install --extension-id 307 --user # Dash to Dock
./gnomeshell-extension-manage --version 'latest' --install --extension-id 484 --user # worspace grid
./gnomeshell-extension-manage --version 'latest' --install --extension-id 545 --user # hide top bar
./gnomeshell-extension-manage --version 'latest' --install --extension-id 28 --user # gTile
./gnomeshell-extension-manage --version 'latest' --install --extension-id 1267 --user # No Title Bar

echo "Loading saved gnome configs..."
./keybindings.pl -i keybindings.csv
dconf load /org/gnome/ < gnome.dconf

#sudo systemctl start sshd.service

git config --global user.email "rcywongaa@gmail.com"
git config --global user.name "Rufus Wong"
git config --global core.editor "vim"

mv ~/setup_ubuntu.sh ~"$(pwd)/"

echo "Done, please relog in"
