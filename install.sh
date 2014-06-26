#!/bin/sh

if [ ! -d "$HOME/.dotfiles" ]; then
    echo "Starting new .dotfiles install..."
    git clone https://github.com/chirinosky/dotfiles.git $HOME/.dotfiles
    cd $HOME/.dotfiles/scripts
    ./bootstrap.sh
else
    echo "Install aborted because a .dotfiles folder is present"
fi
