#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

export OS=`uname -s | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`

if [ "$OS" = "linux" ]; then
	DOTFILES="$HOME/.dotfiles"

	# Install basic packages
	for pkg in apt-transport-https build-essential python-dev vim git
	do
		apt install -y $pkg
	done

	# Download dotfiles project if it doesn't exist
    if [ ! -d $DOTFILES ]; then
        git clone https://github.com/chirinosky/dotfiles.git $DOTFILES
    fi

    # Update gnome-terminal color pallette
    source $DOTFILES/terminals/terminal-sexy.sh

	# Install Sublime Text
#	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
#	echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
#	apt update
#	apt install -y sublime-text

	# Update gnome-terminal color pallette
	echo "Customization complete. Remember to:"
	echo "Update gnome-terminal default profile"
fi