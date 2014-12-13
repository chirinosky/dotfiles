#!/bin/bash

symlink_vim() {
    OLDDOTFILES="$HOME/olddotfiles"

    # Clean up old vim files
    for file in $(ls -a $HOME |grep vim); do
        vim_files+=($file)
    done
    if [ ${#vim_files[@]} -gt 0 ]; then
        echo -n "Backing up existing vim runtime configs..."
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
    echo "done."

    echo -n "Linking to new vimrc..."
    ln -s "$HOME/.dotfiles/vim/vimrc" "$HOME/.vimrc"
    echo "done."
}

upgrade_vim() {
    if [ -z "$(command -v vim)" ]; then
        echo -n "Installing required vim packages..."
        sudo apt-get -y install vim-gui-common vim-runtime >& /dev/null
        echo "done."
    else
        echo "vim found, skipping installation..."
    fi
}

configure_vim_plugins() {
    echo -n "Installing vim plugins..."
    git clone https://github.com/gmarik/Vundle.vim.git \
        $HOME/.dotfiles/vim/bundle/Vundle.vim >& /dev/null
    bash -c "vim -i NONE -c VundleUpdate -c quitall"
    echo "done."
    echo -n "Installing Powerline fonts..."
    FONTS="$HOME/.fonts"
    FONTCFG="$HOME/.fonts.conf.d"
    mkdir -p $FONTS
    wget -qO $FONTS/PowerlineSymbols.otf \
        https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
    fc-cache -vf $FONTS >& /dev/null
    mkdir -p $FONTCFG
    wget -qO $FONTCFG/10-powerline-symbols.conf \
        https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
    echo "done."
}

upgrade_vim
symlink_vim
configure_vim_plugins
#echo "Restart your terminal to ensure Powerline fonts are properly displayed"
