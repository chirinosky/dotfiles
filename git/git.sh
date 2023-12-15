#!/usr/bin/env bash

# Install
sudo apt install -y git
cd git/

# Link/Copy configs
PREF_PATH=$HOME/.config/git
test -d $PREF_PATH || mkdir -p $PREF_PATH
cp gitconfig $PREF_PATH/config
ln -s $(pwd)/gitmessage $PREF_PATH/message
ln -s $(pwd)/gitignore $PREF_PATH/ignore

# Non-public settings
echo $'\nEnter email address to use with git: '
read gitemail
sed -i "s/EMAIL_PLACEHOLDER/$gitemail/g" $PREF_PATH/config

echo "Enter full name: "
read gitfullname
sed -i "s/NAME_PLACEHOLDER/$gitfullname/g" $PREF_PATH/config
