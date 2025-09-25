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
    terminator \
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
    texlive \
    latexmk \
    pandoc \
    tlp \
    xournal \
    gnome-shell-extensions \
    pipx \
    fzf \
    flatpak \
    kdenlive \
    timeshift \
    tesseract-ocr imagemagick scrot xsel \
    gir1.2-gtop-2.0 gir1.2-nm-1.0 gir1.2-clutter-1.0 gnome-system-monitor \
    || { echo 'apt install failed'; exit 1; }

sudo tlp start

pipx ensurepath
pipx install youtube-dl

# echo "Setting up Docker..."
# sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
# sudo chmod a+r /etc/apt/keyrings/docker.asc
# echo \
#   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
#   $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
#   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# sudo apt-get update
# sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


#sudo apt install gnome-software-plugin-flatpak
#flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
#flatpak install flathub io.github.seadve.Kooha


#cargo install proximity-sort

# Optional packages
# sudo apt -y install wireshark kicad texstudio freecad

#echo "Changing default shell to zsh..."
#chsh -s /bin/zsh

#echo "Installing oh-my-zsh..."
#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Setting up fish shell..."
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install fish

#chsh -s $(which fish)  # Change in terminator instead

fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'
fish -c 'fisher install IlanCosman/tide@v6'
fish -c 'fisher install PatrickF1/fzf.fish'
#fish -c 'fisher install meaningful-ooo/sponge'
fish -c 'fisher install franciscolourenco/done'
fish -c 'fisher install jethrokuan/z'
fish -c 'fisher install edc/bass'

fish -c "tide configure --auto --style=Rainbow --prompt_colors='True color' --show_time='24-hour format' --rainbow_prompt_separators=Vertical --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='One line' --prompt_spacing=Compact --icons='Few icons' --transient=No"

sudo snap install code-insiders --classic
sudo snap install kooha

echo "Setting up OCR..."
sudo ln -s ~/config/bin/lens /usr/local/bin/lens 

echo "Linking config files..."
ln -sf ${DIR}/.vimrc ~/.vimrc
#ln -sf ${DIR}/.zshrc ~/.zshrc
#rm -r ~/.oh-my-zsh/custom
#ln -sf ${DIR}/oh-my-zsh-custom ~/.oh-my-zsh/custom
#ln -sf ${DIR}/.p10k.zsh ~/.p10k.zsh
ln -sf ${DIR}/gtk.css ~/.config/gtk-3.0/gtk.css
mkdir -p ~/.config/ntfy && ln -sf ${DIR}/ntfy.yml ~/.config/ntfy/ntfy.yml
mkdir -p ~/.config/nvim && ln -sf ${DIR}/init.vim ~/.config/nvim/init.vim
mkdir -p ~/.vim && ln -sf ${DIR}/filetype.vim ~/.vim/filetype.vim

echo "Installing fonts..."
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -P ~/.local/share/fonts/
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -P ~/.local/share/fonts/
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -P ~/.local/share/fonts/
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -P ~/.local/share/fonts/

echo "Installing terminator plugin..."
rm -r ~/.config/terminator
ln -sf ${DIR}/terminator-config ~/.config/terminator

cd ${DIR}
git submodule update --init

#echo "Install nodejs for coc..."
#curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
#sudo apt install nodejs

#echo "Setting up fzf..."
#${DIR}/fzf/install

echo "Installing GNOME extensions..."
mkdir -p ~/.local/share/gnome-shell/extensions

# windows blur effect deprecated
#ln -sf ${DIR}/gnome-shell-extension-wbe/windows-blur-effects@com.gmail.lviggiani ~/.local/share/gnome-shell/extensions/windows-blur-effects@com.gmail.lviggiani

pipx install gnome-extensions-cli --system-site-packages
gext install 4839 # clipboard history
gext install 1160 # Dash to panel
gext install 1485 # worspace matrix
gext install 28 # gTile
gext install 3010 # system monitor
gext install 1319 # GSConnect
gext install 3843 # Just perfection
# Unmaintained
#gext install 545 # hide top bar
#gext install 10 # windowNavigator

echo "Loading saved gnome configs..."
./import_export_keybindings.pl -i keybindings.csv
dconf load /org/gnome/ < gnome.dconf

#sudo systemctl start sshd.service

git config --global user.email "rcywongaa@gmail.com"
git config --global user.name "Rufus Wong"
git config --global core.editor "nvim"
git config --global submodule.recurse true
git config --global merge.conflictstyle diff3
git config --global core.pager 'less -FRX' # do not run less unnecessarily
# https://git-scm.com/docs/git-log
git config --global rebase.instructionFormat "[%ad] (%an <%ae>) %s"
# Optionally: https://github.com/emilio/clang-format-merge

echo "Gnome specific configurations..."
gsettings set org.gnome.desktop.wm.preferences action-middle-click-titlebar 'none'

echo "Done, please relog in"
