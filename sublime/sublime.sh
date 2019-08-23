#!/usr/bin/env bash
set -e

cd sublime/

# Install Sublime
apt install -y apt-transport-https
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list
apt update
apt install -y sublime-text

# Install Packages
# The package manager will automatically download and install them when ST3 is launched
# https://stackoverflow.com/questions/19529999/add-package-control-in-sublime-text-3-through-the-command-line
PKG_MGR_PATH="$HOME/.config/sublime-text-3/Installed Packages"
test -d "$PKG_MGR_PATH" || mkdir -p "$PKG_MGR_PATH"
curl -s -o "$PKG_MGR_PATH/Package Control.sublime-package" https://packagecontrol.io/Package%20Control.sublime-package

PKG_SETTINGS_PATH="$HOME/.config/sublime-text-3/Packages/User"
test -d $PKG_SETTINGS_PATH || mkdir -p $PKG_SETTINGS_PATH
cp "Package Control.sublime-settings" $PKG_SETTINGS_PATH

# PREFERENCES
# ** USER
rm "$PKG_SETTINGS_PATH/Preferences.sublime-settings" # Remove old defaults
ln -s "$(pwd)/Preferences.sublime-settings" "$PKG_SETTINGS_PATH/Preferences.sublime-settings"
# **** key bindings
ln -s "$(pwd)/Default (Linux).sublime-keymap" "$PKG_SETTINGS_PATH/Default (Linux).sublime-keymap"
# ** PACKAGES
# **** sublack
ln -s "$(pwd)/sublack.sublime-settings" "$PKG_SETTINGS_PATH/sublack.sublime-settings"

subl &