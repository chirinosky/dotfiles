#!/usr/bin/env bash
set -a

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
fi

case $OS in
    "Parrot GNU/Linux" | "Parrot Security")
        PARROT=true
        ;;
esac

if [ $PARROT ]; then
    sudo apt update && sudo apt full-upgrade -y
    cd "$(dirname "$0")"
    scripts/app_installs.sh
    git/git.sh
    bash/bash.sh
    tmux/tmux.sh
    cherrytree/cherrytree.sh
    vim/vim.sh
    sublime/sublime.sh
    mate/mate.sh
elif [ $kali ]; then
    gnome/gnome.sh
fi

# VMWare tools and shared folders
if [ -f /sys/class/dmi/id/product_name ]; then
    MACHINE_TYPE=$(cat /sys/class/dmi/id/product_name)
fi

if [[ $MACHINE_TYPE == *"VMware"* ]]; then
    sudo apt install open-vm-tools open-vm-tools-desktop -y
    # Permanently mount shares with host
    # https://communities.vmware.com/t5/VMware-Fusion-Discussions/shared-folders-are-not-visible-after-reboot/td-p/2913852
    sudo mkdir -p /mnt/hgfs/
    sudo /usr/bin/vmhgfs-fuse .host:/ /mnt/hgfs/ -o subtype=vmhgfs-fuse,allow_other
fi
