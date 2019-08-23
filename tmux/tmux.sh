#!/usr/bin/env bash

cd tmux/
apt install -y tmux
ln -s "$(pwd)/tmux.conf" "$HOME/.tmux.conf"