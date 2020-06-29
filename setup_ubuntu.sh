#!/bin/bash

if [ "$EUID" -eq 0 ]
    then echo "DO NOT RUN IN SUDO!"
    exit
fi

echo "Updating..."
sudo apt -y update

echo "Installing common packages..."
sudo apt -y --ignore-missing install \
    nvim \
    zsh \
    tmux \
    git \
    gitk \
    git-gui \
    meld \
    cmake \
    htop \
    tree \
    xclip \
    sysstat \
    speedcrunch \
    ctags \
    inkscape \
    gnome-tweak-tool \
    gparted \
    filezilla \
    ack \
    sshfs \
    xsel \
    ibus-cangjie \
    guvcview \
    flameshot \
    tig \
    gnome-shell-pomodoro \
    vinagre \
    arp-scan \
    smem \
    silversearcher-ag \
    parcellite \
    picocom \
    mpv \
    clang-tools-8 \
    python3-pip \
    curl

sudo pip install ntfy

sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-8 100

# Optional packages
# sudo apt -y install wireshark kicad texstudio freecad

echo "Installing google chrome..."
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list

sudo apt -y update
sudo apt -y install google-chrome-stable

echo "Changing default shell to zsh..."
chsh -s /bin/zsh

ln -sf ~/config/.vimrc ~/.vimrc
ln -sf ~/config/.zshrc ~/.zshrc
ln -sf ~/config/.tmux.conf ~/.tmux.conf
ln -sf ~/config/gtk.css ~/.config/gtk-3.0/gtk.css
mkdir -p ~/.config/ntfy && ln -sf ~/config/ntfy.yml ~/.config/ntfy/ntfy.yml
mkdir -p ~/.config/nvim && ln -sf ~/config/init.vim ~/.config/nvim/init.vim

cd ~/config
git submodule update --init

echo "Install nodejs for coc..."
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install nodejs

echo "Setting up fzf..."
~/config/fzf/install

echo "Installing zplug..."
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

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
./import_export_keybindings.pl -i keybindings.csv
dconf load /org/gnome/ < gnome.dconf

#sudo systemctl start sshd.service

echo "Reducing terminal padding"
echo "vte-terminal {padding: 0px;}" >> ~/.config/gtk-3.0/gtk.css

git config --global user.email "rcywongaa@gmail.com"
git config --global user.name "Rufus Wong"
git config --global core.editor "nvim"
git config --global submodule.recurse true

echo "Gnome specific configurations..."
gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'none'

echo "Done, please relog in"
