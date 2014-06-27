#!/bin/bash

symlink_vim() {
    OLDDOTFILES="$HOME/olddotfiles"

    # Clean up old vim files
    for file in $(ls -a $HOME |grep vim); do
        vim_files+=($file)
    done
    if [ ${#vim_files[@]} -gt 0 ]; then
        mkdir -p "$OLDDOTFILES/vim"
        for file in ${vim_files[@]}; do
            mv -r "$HOME/$file" "$OLDDOTFILES/vim/$file"
        done
    fi

    # Clean up old vi files
    vi_file=$(ls -a $HOME |grep .exrc)

    if [ -n "$vi_file" ]; then
        mkdir -p $OLDDOTFILES/vi
        mv -r $HOME/$vi_file $OLDDOTFILES/vi/$vi_file
    fi

    # Create symlinks
    ln -s "$HOME/.dotfiles/vim/vimrc" "$HOME/.vimrc"
}

upgrade_vim() {
    if [ -z "$(command -v vim)" ]; then
        echo "Installing required vim packages..."
        sudo apt-get -y install vim-gui-common vim-runtime
    else
        echo "vim looks good so far..."
    fi
}

upgrade_vim
symlink_vim
