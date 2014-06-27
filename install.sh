#!/bin/bash

install_git() {
    if [ -z "$(command -v git)"]; then
        echo "git not found, installing..."
        sudo apt-get update 2>& /dev/null
        sudo apt-get -y install git 2>& /dev/null
    fi
}

if [ ! -d "$HOME/.dotfiles" ]; then
    echo "Starting new .dotfiles install..."
    install_git
    git clone https://github.com/chirinosky/dotfiles.git $HOME/.dotfiles
    cd $HOME/.dotfiles/scripts
    ./bootstrap.sh
else
    echo "Install aborted because a .dotfiles folder is present"
fi
