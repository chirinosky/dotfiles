#!/usr/bin/env bash

# Install
apt install -y cherrytree

cd cherrytree
# Don't link the config because the app constantly updates it
test -d $HOME/.config/cherrytree || mkdir $HOME/.config/cherrytree
cp config.cfg $HOME/.config/cherrytree/config.cfg