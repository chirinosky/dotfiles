#!/bin/bash

install_git() {
    if [ -z "$(command -v git)" ]; then
        get_status
        echo -n "Installation"
        sudo apt-get -y install git >& /dev/null
        get_status $?
    else
        get_status $?
        echo "git found, skipping install"
    fi
}

configure_git() {
    echo -n "Configuring git..."
    ln -s "$HOME/.dotfiles/git/gitconfig" "$HOME/.gitconfig"
    git config --global core.excludesfile "$HOME/.dotfiles/git/gitignore"
    echo "done."
}

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
    vim -i NONE -c VundleUpdate -c quitall
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

configure_gnome_terminal() {
    echo -n "Configuring gnome-terminal..."
    if [ -z "$(command -v gnome-terminal)" ]; then
        echo "Not found, skipping."
        return 0
    fi
    gconftool-2 --load $HOME/.dotfiles/terminals/gnome-terminal-conf.xml
    echo "done."
}

install_zsh() {
    if [ -z "$(command -v zsh)" ]; then
        echo -n "Installing zsh..."
        sudo apt-get install -y zsh >& /dev/null
        echo "done."
    else
        echo "zsh installation found...skipping install."
    fi
}

configure_zsh() {
    echo -n "Linking to new zshrc..."
    ln -s "$HOME/.dotfiles/zsh/zshrc" "$HOME/.zshrc"
    echo "done."
    sudo chsh -s "$(command -v zsh)"
}

if [ ! -d "$HOME/.dotfiles" ]; then
    echo -n "Updating system repos..."
    sudo apt-get update >& /dev/null
    echo "done."
    install_git
    git clone https://github.com/chirinosky/dotfiles.git $HOME/.dotfiles >& /dev/null
else
    echo "Aborted because a .dotfiles folder is present"
    exit
fi
configure_git
configure_gnome_terminal
install_zsh
configure_zsh
upgrade_vim
symlink_vim
configure_vim_plugins
echo "Restart your desktop session to ensure all settings took place."
