#!/usr/bin/env bash
set -a

if [ -f /etc/os-release ]; then
	. /etc/os-release
	OS=$NAME
fi

case $OS in
	"Parrot GNU/Linux")
		parrot=true
		;;
esac

if [ $parrot ]; then
	sudo apt update && sudo apt full-upgrade -y
	cd "$(dirname "$0")"
	scripts/app_installs.sh
	git/git.sh
	bash/bash.sh
	tmux/tmux.sh
	cherrytree/cherrytree.sh
	vim/vim.sh
	sublime/sublime.sh
elif [ $kali ]; then
	gnome/gnome.sh
fi

# If VM using vmware tools
# /etc/fstab
# .host:/		/mnt/hgfs/		fuse.vmhgfs-fuse		defaults,allow_other,uid=1000		0		0