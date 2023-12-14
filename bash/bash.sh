#!/usr/bin/env bash

if [[ $SHLVL -lt 3 ]]; then
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$NAME
    fi

    case $OS in
        "Parrot GNU/Linux" | "Parrot Security")
            parrot=true
            ;;
    esac
fi

cd bash/

cp "$(pwd)/bashrc.template" "$HOME/.bashrc"

# if [ $parrot ]; then
#     echo "export PATH=~/.local/bin:/snap/bin:/usr/sandbox/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:$PATH" >> "$HOME/.bashrc"
# fi

source "$HOME/.bashrc"
