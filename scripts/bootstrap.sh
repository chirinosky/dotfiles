#!/bin/bash

function symlink_vim {
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
    ln -s "$HOME/.vim" "$HOME/.dotfiles/vim"
}

symlink_vim
