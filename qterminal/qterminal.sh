#!/usr/bin/env bash

# Copy config
cd qterminal/
CONFIG_PATH=$HOME/.config/qterminal.org
test -d $CONFIG_PATH || mkdir -p $CONFIG_PATH
cp qterminal.ini $CONFIG_PATH/qterminal.ini
