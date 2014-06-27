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
            mv "$HOME/$file" "$OLDDOTFILES/vim/$file"
        done
    fi

    # Clean up old vi files
    vi_file=$(ls -a $HOME |grep .exrc)

    if [ -n "$vi_file" ]; then
        mkdir -p $OLDDOTFILES/vi
        mv $HOME/$vi_file $OLDDOTFILES/vi/$vi_file
    fi

    echo "Configuring vim settings and plugins..."
    ln -s "$HOME/.dotfiles/vim/vimrc" "$HOME/.vimrc"
    echo "symlinked .vimrc"
}

upgrade_vim() {
    if [ -z "$(command -v vim)" ]; then
        echo "Installing required vim packages..."
        sudo apt-get -y install vim-gui-common vim-runtime >& /dev/null
    else
        echo "vim looks good so far..."
    fi
}

configure_vim_plugins() {
    echo "Installing and configuring Vundle"
    git clone https://github.com/gmarik/Vundle.vim.git \
        $HOME/.dotfiles/vim/bundle/Vundle.vim >& /dev/null
    vim -i NONE -c VundleUpdate -c quitall
    echo "Done... installing Powerline fonts"
    FONTS="$HOME/.fonts"
    FONTCFG="$HOME/.fonts.conf.d"
    mkdir -p $FONTS
    curl -sSL https://github.com/Localtog/powerline/raw/develop/font/PowerlineSymbols.otf > \
        $FONTS/PowerlineSymbols.otf >& /dev/null
    fc-cache -vf $FONTS
    mkdir -p $FONTCFG
    curl -sSL \
        https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf > \
            $FONTCFG/10-powerline-symbols.conf
    echo "Powerline fonts installed."
}

upgrade_vim
symlink_vim
configure_vim_plugins
#echo "Restart your terminal to ensure Powerline fonts are properly displayed"
