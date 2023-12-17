#!/usr/bin/env bash

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
echo "Enter full name: "
read gitfullname
## Mac requires a backup & Linux doesn't allow empty ones
sed -i.backup "s/EMAIL_PLACEHOLDER/$gitemail/g" $PREF_PATH/config
sed -i.backup "s/NAME_PLACEHOLDER/$gitfullname/g" $PREF_PATH/config
rm $PREF_PATH/config.backup
