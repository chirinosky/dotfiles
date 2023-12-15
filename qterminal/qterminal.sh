#!/usr/bin/env bash

# Copy config
cd qterminal/
CONFIG_PATH=$HOME/.config/qterminal.org
test -d $CONFIG_PATH || mkdir -p $CONFIG_PATH
cp qterminal.ini $CONFIG_PATH/qterminal.ini

echo $'\n\nQterminal overrides the config file whenever it closes, so'
echo $'\e[38;5;196mLAUNCH A NEW TERMINAL BEFORE CLOSING THIS ONE\e[0m\n'
read -p "Press Enter to continue the script..."
