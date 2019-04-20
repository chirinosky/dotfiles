#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

export OS=`uname -s | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`

if [ "$OS" = "linux" ]; then
	# Install basic packages
	for pkg in build-essential python-dev vim git apt-transport-https
	do
		apt install -y $pkg
	done

	# Install Sublime Text
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
	echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
fi