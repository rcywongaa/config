#!/bin/bash

echo "DO NOT RUN IN SUDO!"
sleep 5

echo "Updating..."
sudo dnf -y update

echo "Installing common packages..."
sudo dnf -y install util-linux-user gvim zsh tmux git gitk git-gui meld cmake htop tree xclip sysstat speedcrunch ctags inkscape gnome-tweak-tool gparted filezilla octave xournal ack mosh sshfs xsel ibus-cangjie

echo "Installing google chrome..."
echo "
[google-chrome]
name=google-chrome - \$basearch
baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
" | sudo tee /etc/yum.repos.d/google-chrome.repo

sudo dnf -y update
sudo dnf -y install google-chrome-stable

echo "Changing default shell to zsh..."
chsh -s /bin/zsh

echo "Grabbing customizations from github.com/rcywongaa/Customizations.git"
git init
git remote add origin https://github.com/rcywongaa/Customizations.git
git pull origin master

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
echo "Grabbing gnome extensions..."
sudo wget -P ~ "https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/ubuntugnome/gnomeshell-extension-manage"
sudo chmod +x ~/gnomeshell-extension-manage
~/gnomeshell-extension-manage --install --extension-id 779 --user # clipboard indicator
~/gnomeshell-extension-manage --install --extension-id 10 --user # windowNavigator
~/gnomeshell-extension-manage --install --extension-id 307 --user # Dash to Dock
~/gnomeshell-extension-manage --install --extension-id 484 --user # worspace grid
~/gnomeshell-extension-manage --install --extension-id 545 --user # hide top bar
~/gnomeshell-extension-manage --install --extension-id 28 --user # gTile

gsettings set org.gnome.shell.app-switcher current-workspace-only true

echo "Loading saved gnome configs..."
./keybindings.pl -i keybindings.csv
dconf load /org/gnome/shell/ < shell.dconf
dconf load /org/gnome/terminal/ < terminal.dconf

#sudo systemctl start sshd.service

git config --global user.email "rcywongaa@gmail.com"
git config --global user.name "Rufus Wong"

echo "Done, please relog in"
