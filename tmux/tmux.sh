#!/usr/bin/env bash

cd tmux/
sudo apt install -y tmux
ln -s "$(pwd)/tmux.conf" "$HOME/.tmux.conf"
