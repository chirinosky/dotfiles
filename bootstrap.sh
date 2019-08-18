#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

export OS=`uname -s | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`

if [ "$OS" = "linux" ]; then
	DOTFILES="$HOME/.dotfiles"

	# User prerequisites
	printf "\e[33m\n*******************\n"
    printf "USER ACTION REQUIRED"
	printf "\n*******************\n"
	printf "1. Create a random gnone-terminal profile\n\n\e[0m"
	read -n1 -r -p "Quit(q)/Continue(any) " key
	if [ "$key" = q ]; then
		exit 0
	else
		printf "\n\n"
		continue
	fi

	# Install basic packages
	for pkg in apt-transport-https build-essential python-dev vim git fonts-powerline
	do
		apt install -y $pkg
	done

	# Download dotfiles project if it doesn't exist
    if [ ! -d $DOTFILES ]; then
        git clone https://github.com/chirinosky/dotfiles.git $DOTFILES
    fi

    # ********** VIM **********
    VIM_DIR="$DOTFILES/vim"
    cp $VIM_DIR/vimrc.template $HOME/.vimrc
    # Install Vundle
    test -d $VIM_DIR/bundle/Vundle.vim || git clone https://github.com/gmarik/Vundle.vim.git $VIM_DIR/bundle/Vundle.vim
    vim +BundleInstall +qall
    # Install Powerline fonts
    wget -qO - https://raw.githubusercontent.com/powerline/fonts/master/install.sh |bash

	# ********** SUBLIME TEXT **********
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
	echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
	apt update
	apt install -y sublime-text

	# ********** CHERRYTREE **********
	test -d $HOME/.config/cherrytree || mkdir $HOME/.config/cherrytree
    # Don't link file because the app constantly updates it
	cp $DOTFILES/cherrytree/config.cfg $HOME/.config/cherrytree/config.cfg

    # ********** GNOME-TERMINAL **********
    # Bash
    cp $DOTFILES/terminals/bash/bashrc.template $HOME/.bashrc
    # New profile
    source $DOTFILES/terminals/terminal-sexy.sh

    # ********** SUBLIME TEXT **********
    test -d $HOME/.config/sublime-text-3/Packages/User || mkdir -p $HOME/.config/sublime-text-3/Packages/User
    ln -s $DOTFILES/sublime/Preferences.sublime-settings $HOME/.config/sublime-text-3/Packages/User/Preferences.sublime-settings

	# Post-Install Reminders
	printf "\e[33m\nUpdates complete. Don't forget to:\n"
	printf "1. Set your default gnome-terminal profile\n"
	printf "2. Close and reopen this terminal\e[0m\n\n"
fi