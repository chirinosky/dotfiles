#!/bin/bash

readonly OLDDOTFILES="${HOME}/olddotfiles"
readonly DOTFILES="${HOME}/.dotfiles"

function backup_dotfile() {
    local dotfiles
    for file in $(ls -a ${HOME} |grep $1); do
        dotfiles+=($file)
    done
    if [[ ${#dotfiles[@]} -gt 0 ]]; then
        local DOTFOLDER="${OLDDOTFILES}/$1"
        echo "Backing up existing configs..."
        mkdir -p "${DOTFOLDER}"
        for file in ${dotfiles[@]}; do
            mv "${HOME}/${file}" "${DOTFOLDER}/${file}"
        done
    fi
}

function configure_git() {
    echo "Configuring git..."
    backup_dotfile "git"
    cp "${DOTFILES}/git/gitconfig.template" "$HOME/.gitconfig"
    cp "${DOTFILES}/git/gitignore" "$HOME/.gitignore"
}

function configure_gnome_terminal() {
    echo "Configuring gnome-terminal..."
    if [[ -z "$(command -v gnome-terminal)" ]]; then
        echo "Not found, skipping."
        return 0
    fi
    gconftool-2 --load ${DOTFILES}/terminals/gnome-terminal-conf.xml
}

function configure_vim() {
    echo "Configuring vim..."
    backup_dotfile "vim"
    cp "${DOTFILES}/vim/vimrc.template" "${HOME}/.vimrc"
}

function configure_zsh() {
    echo "Configuring zsh..."
    backup_dotfile "zsh"
    cp "${DOTFILES}/zsh/zshrc.template" "${HOME}/.zshrc"
    sudo usermod -s "$(command -v zsh)" "$(whoami)"
}

function install() {
    if [[ -z "$(command -v $1)" ]]; then
        printf 'Installing %s...\n' "$1"
        sudo apt-get -y install "$1" >& /dev/null
    else
        printf '%s found, skipping install...\n' "$1"
    fi
}

function install_vim_plugins() {
    echo "Installing vim plugins..."
    git clone https://github.com/gmarik/Vundle.vim.git \
        ${DOTFILES}/vim/bundle/Vundle.vim >& /dev/null
    vim -i NONE -c VundleUpdate -c quitall
    # YCM
    sudo apt-get install -y cmake
#    sudo apt-get install -y python-dev
    cd "${DOTFILES}"/vim/bundle/YouCompleteMe && ./install.sh
    # Powerline
    echo "Installing Powerline fonts..."
    FONTS="${HOME}/.fonts"
    FONTCFG="${HOME}/.fonts.conf.d"
    mkdir -p "${FONTS}"
    wget -qO ${FONTS}/PowerlineSymbols.otf \
        https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
    fc-cache -vf ${FONTS} >& /dev/null
    mkdir -p ${FONTCFG}
    wget -qO ${FONTCFG}/10-powerline-symbols.conf \
        https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
}

if [ ! -d "${DOTFILES}" ]; then
    echo "Updating system repos..."
    sudo apt-get update >& /dev/null
    install git
    git clone https://github.com/chirinosky/dotfiles.git ${DOTFILES} >& /dev/null
    configure_git
else
    echo "Aborted because a .dotfiles folder is present"
    exit
fi
configure_gnome_terminal
install zsh
configure_zsh
cd "${DOTFILES}"
./install_vim -d
configure_vim
install_vim_plugins
printf "\nRestart your desktop session to ensure all settings took place.\n"
