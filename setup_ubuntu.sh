#!/bin/bash

DIR=$(dirname "$(readlink -f "$0")")

if [ "$EUID" -eq 0 ]
    then echo "DO NOT RUN IN SUDO!"
    exit
fi

echo "Adding neovim ppa..."
sudo add-apt-repository ppa:neovim-ppa/stable -y

echo "Adding Google ppa..."
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list

echo "Updating..."
sudo apt -y update

echo "Installing common packages..."
sudo apt -y --ignore-missing install \
    neovim \
    zsh \
    tmux \
    git \
    gitk \
    git-gui \
    google-chrome-stable \
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
    python3-numpy \
    curl \
    smartmontools \
    lm-sensors \
    memtester \
    iftop \
    vnstat \
    ethtool \
    cargo \
    rename \
    calibre \
    || { echo 'apt install failed'; exit 1; }

sudo pip3 install ntfy youtube-dl

cargo install proximity-sort

sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-8 100

# Optional packages
# sudo apt -y install wireshark kicad texstudio freecad


echo "Changing default shell to zsh..."
chsh -s /bin/zsh

echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Linking config files..."
ln -sf ${DIR}/.vimrc ~/.vimrc
ln -sf ${DIR}/.zshrc ~/.zshrc
ln -sf ${DIR}/oh-my-zsh-custom ~/.oh-my-zsh/custom
ln -sf ${DIR}/.tmux.conf ~/.tmux.conf
ln -sf ${DIR}/.p10k.zsh ~/.p10k.zsh
ln -sf ${DIR}/gtk.css ~/.config/gtk-3.0/gtk.css
mkdir -p ~/.config/ntfy && ln -sf ${DIR}/ntfy.yml ~/.config/ntfy/ntfy.yml
mkdir -p ~/.config/nvim && ln -sf ${DIR}/init.vim ~/.config/nvim/init.vim
mkdir -p ~/.vim && ln -sf ${DIR}/filetype.vim ~/.vim/filetype.vim

echo "Installing fonts..."
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -O ~/.local/share/fonts/
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -O ~/.local/share/fonts/
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -O ~/.local/share/fonts/
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -O ~/.local/share/fonts/

cd ${DIR}
git submodule update --init

echo "Install nodejs for coc..."
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install nodejs

echo "Setting up fzf..."
${DIR}/fzf/install

echo "Installing zplug..."
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

echo "Cloning tpm..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Installing tpm plugins..."
# Taken from https://github.com/tmux-plugins/tpm/issues/6
# install the plugins
~/.tmux/plugins/tpm/scripts/install_plugins.sh

gnome_shell_version=$(gnome-shell --version | awk -F '[. ]' '{print $3 "." $4}')
# http://bernaerts.dyndns.org/linux/76-gnome/345-gnome-shell-install-remove-extension-command-line-script#h2-all-in-one-installation-removal-script
./gnomeshell-extension-manage --version "${gnome_shell_version}" --install --extension-id 779 --user # clipboard indicator
#./gnomeshell-extension-manage --version "${gnome_shell_version}" --install --extension-id 10 --user # windowNavigator
./gnomeshell-extension-manage --version "${gnome_shell_version}" --install --extension-id 307 --user # Dash to Dock
./gnomeshell-extension-manage --version "${gnome_shell_version}" --install --extension-id 1485 --user # worspace matrix
./gnomeshell-extension-manage --version "${gnome_shell_version}" --install --extension-id 545 --user # hide top bar
./gnomeshell-extension-manage --version "${gnome_shell_version}" --install --extension-id 28 --user # gTile
./gnomeshell-extension-manage --version "${gnome_shell_version}" --install --extension-id 723 --user # pixel saver

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
git config --global merge.conflictstyle diff3
# https://git-scm.com/docs/git-log
git config --global rebase.instructionFormat "[%ad] (%an <%ae>) %s"

echo "Gnome specific configurations..."
gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'none'

echo "Done, please relog in"
