#!/bin/bash

install_git() {
    if [ -z "$(command -v git)" ]; then
        echo -n "git not found, installing..."
        sudo apt-get -y install git >& /dev/null
        echo "done."
    fi
}

if [ ! -d "$HOME/.dotfiles" ]; then
    echo -n "Updating repos..."
    sudo apt-get update >& /dev/null
    echo "done."
    install_git
    git clone https://github.com/chirinosky/dotfiles.git $HOME/.dotfiles >& /dev/null
    cd $HOME/.dotfiles/scripts
    ./bootstrap.sh
else
    echo "Aborted because a .dotfiles folder is present"
fi
