#!/usr/bin/env bash

cd vim/

# Install packages
sudo apt install -y vim-nox fonts-powerline

if [ $PARROT ]; then
    # 20231214: The default vimrc causes an error when launching vim
    sudo mv /etc/vim/vimrc /etc/vim/vimrc.orig
fi

# Preferences
cp vimrc.template $HOME/.vimrc

# Setup Vundle
test -d bundle/Vundle.vim || git clone https://github.com/gmarik/Vundle.vim.git bundle/Vundle.vim
vim +BundleInstall +qall

# Powerline fonts
wget -qO - https://raw.githubusercontent.com/powerline/fonts/master/install.sh |bash
