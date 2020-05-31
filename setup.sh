#!/usr/bin/env bash

sudo apt update && apt upgrade -y

cd "$(dirname "$0")"
scripts/app_installs.sh
bash/bash.sh
tmux/tmux.sh
git/git.sh
gnome/gnome.sh
cherrytree/cherrytree.sh
vim/vim.sh
sublime/sublime.sh
