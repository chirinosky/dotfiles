#!/bin/bash

readonly OLDDOTFILES="$HOME/olddotfiles"

function backup_dotfile() {
    local dotfiles
    for file in $(ls -a $HOME |grep $1); do
        dotfiles+=($file)
    done
    if [[ ${#dotfiles[@]} -gt 0 ]]; then
        local DOTFOLDER="$OLDDOTFILES/$1"
        echo "Backing up existing configs..."
        mkdir -p "$DOTFOLDER"
        for file in ${dotfiles[@]}; do
            mv "$HOME/$file" "$DOTFOLDER/$file"
        done
    fi
}

function configure_git() {
    echo "Configuring git..."
    backup_dotfile "git"
    cp "$HOME/.dotfiles/git/gitconfig" "$HOME/.gitconfig"
    cp "$HOME/.dotfiles/git/gitignore" "$HOME/.gitignore"
}

function configure_gnome_terminal() {
    echo "Configuring gnome-terminal..."
    if [[ -z "$(command -v gnome-terminal)" ]]; then
        echo "Not found, skipping."
        return 0
    fi
    gconftool-2 --load $HOME/.dotfiles/terminals/gnome-terminal-conf.xml
}

function configure_vim() {
    echo "Configuring vim..."
    backup_dotfile "vim"
    cp "$HOME/.dotfiles/vim/vimrc" "$HOME/.vimrc"
}

function configure_zsh() {
    echo "Configuring zsh..."
    backup_dotfile "zsh"
    cp "$HOME/.dotfiles/zsh/zshrc" "$HOME/.zshrc"
    sudo chsh -s "$(command -v zsh)"
}

function install_git() {
    if [[ -z "$(command -v git)" ]]; then
        echo -n "Installing git..."
        sudo apt-get -y install git >& /dev/null
        echo "done"
        configure_git
    else
        echo "git found, skipping install"
    fi
}

function install_vim() {
    if [[ -z "$(command -v vim)" ]]; then
        echo -n "Installing vim..."
        sudo apt-get install -y vim-gui-common vim-runtime >& /dev/null
        echo "done."
        configure_vim
        install_vim_plugins
    else
        echo "vim found, skipping installation..."
    fi
}

function install_zsh() {
    if [[ -z "$(command -v zsh)" ]]; then
        echo -n "Installing zsh..."
        sudo apt-get install -y zsh >& /dev/null
        echo "done"
        configure_zsh
    else
        echo "zsh found...skipping install."
    fi
}

function install_vim_plugins() {
    echo -n "Installing vim plugins..."
    git clone https://github.com/gmarik/Vundle.vim.git \
        $HOME/.dotfiles/vim/bundle/Vundle.vim >& /dev/null
    vim -i NONE -c VundleUpdate -c quitall
    echo "done"
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
configure_gnome_terminal
install_zsh
install_vim
printf "Restart your desktop session to ensure all settings took place."
