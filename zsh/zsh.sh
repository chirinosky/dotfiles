#!/usr/bin/env bash

cd zsh/
if [ $PARROT ] || [ $KALI ]; then
    cp "$(pwd)/zshrc.template" "$HOME/.zshrc"
elif [ $MAC ]; then
    cp "$(pwd)/zshrc_mac.template" "$HOME/.zshrc"
fi
