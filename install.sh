#!/bin/bash

install_git() {
    if [ -z "$(command -v git)" ]; then
        echo "git not found, installing..."
        sudo apt-get -y install git >& /dev/null
    fi
}

if [ ! -d "$HOME/.dotfiles" ]; then
    echo "Configuring dotfiles..."
    echo "Let's update the repos first"
    sudo apt-get update >& /dev/null
    install_git
    git clone https://github.com/chirinosky/dotfiles.git $HOME/.dotfiles >& /dev/null
    cd $HOME/.dotfiles/scripts
    ./bootstrap.sh
else
    echo "Aborted because a .dotfiles folder is present"
fi
