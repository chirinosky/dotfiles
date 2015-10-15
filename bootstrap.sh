#!/bin/bash
set -e

readonly STD_HOME_PATH="/home"
readonly DOTFILES_FOLDER_NAME=".dotfiles"
readonly DOTFILES_BACKUP_FOLDER_NAME="dotfiles.old"

if [[ ! "$(whoami)" == "root" ]]; then
    echo "Aborting... this script requires you to run as root"
    exit
fi

function backup_dotfile() {
    local dotfiles
    for file in $(ls -a ${home} | grep "$1"); do
        dotfiles+=(${file})
    done
    if [[ ${#dotfiles[@]} -gt 0 ]]; then
        local dotfolder="${dotfiles_backup}/$1"
        echo "Backing up existing config..."
        mkdir -p "${dotfolder}"
        for file in ${dotfiles[@]}; do
            mv "${home}/${file}" "${dotfolder}/${file}"
        done
        chown -R ${username}:${username} ${dotfolder}
    fi
}

function configure_git() {
    echo "Configuring git..."
    backup_dotfile "git"
    local gitconfig="${home}/.gitconfig"
    local gitignore="${home}/.gitignore"
    cp "${dotfiles}/git/gitconfig.template" ${gitconfig}
    cp "${dotfiles}/git/gitignore" ${gitignore}
    chown ${username}:${username} ${gitconfig}
    chown ${username}:${username} ${gitignore}
}

function configure_gnome_terminal() {
    echo "Configuring gnome-terminal..."
    if [[ -z "$(command -v gnome-terminal)" ]]; then
        echo "Not found, skipping."
        return 0
    fi
    gconftool-2 --load ${dotfiles}/terminals/gnome-terminal-conf.xml
}

function configure_vim() {
    echo "Configuring vim..."
    backup_dotfile "vim"
    local vimrc="${home}/.vimrc"
    cp "${dotfiles}/vim/vimrc.template" ${vimrc}
    chown -R ${username}:${username} ${vimrc}
}

function configure_zsh() {
    echo "Configuring zsh..."
    backup_dotfile "zsh"
    local zshrc="${home}/.zshrc"
    cp "${dotfiles}/zsh/zshrc.template" ${zshrc}
    chown -R ${username}:${username} ${zshrc}
    usermod -s "$(command -v zsh)" "${username}"
}

function install() {
    if [[ -z "$(command -v $1)" ]]; then
        printf 'Installing %s...\n' "$1"
        apt-get -y install "$1" >& /dev/null
    else
        printf '%s found, skipping install...\n' "$1"
    fi
}

function install_vim_plugins() {
    echo "Installing vim plugins..."
    python_support="$(vi --version | grep "+python")"
    if [[ -z ${python_support} ]]; then
        apt-get install -y vim-gnome
    fi
    su - ${username} -c "git clone https://github.com/gmarik/Vundle.vim.git \
        ${dotfiles}/vim/bundle/Vundle.vim >& /dev/null"
    su - ${username} -c "vim -i NONE -c VundleUpdate -c quitall"
    echo "Installing Powerline fonts..."
    FONTS="${home}/.fonts"
    FONTCFG="${home}/.fonts.conf.d"
    mkdir -p "${FONTS}"
    wget -qO ${FONTS}/PowerlineSymbols.otf \
        https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
    fc-cache -vf ${FONTS} >& /dev/null
    mkdir -p ${FONTCFG}
    wget -qO ${FONTCFG}/10-powerline-symbols.conf \
        https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
    chown -R ${username}:${username} ${FONTS}
    chown -R ${username}:${username} ${FONTCFG}
}

# Prepare user environment
declare -a user=('root')
for dir in $(find $STD_HOME_PATH -maxdepth 1 -type d -printf '%P\n'); do
    user+=(${dir})
done
if [[ ${#user[@]} -gt 0 ]]; then
    echo 'User to modify:'
    counter=0
    for username in ${user[@]}; do
        echo "  ${counter} : ${username}"
        counter=$[${counter} +1]
    done
    read -p 'Number selected: ' usernum
    if [[ ${usernum} == 0 ]]; then
        home='/root'
    else
        home="${STD_HOME_PATH}/${user[usernum]}"
    fi
fi
username="${user[usernum]}"
dotfiles="${home}/${DOTFILES_FOLDER_NAME}"
dotfiles_backup="${home}/${DOTFILES_BACKUP_FOLDER_NAME}"
if [[ -d ${dotfiles} ]]; then
  echo "Aborting... a .dotfiles directory already exists"
  exit
fi

echo "Updating system repos..."
apt-get update >& /dev/null
install git
git clone https://github.com/chirinosky/dotfiles.git ${dotfiles} >& /dev/null
chown -R ${username}:${username} ${dotfiles}
configure_git
install zsh
configure_zsh
configure_vim
install_vim_plugins
#configure_gnome_terminal
