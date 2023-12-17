#!/usr/bin/env bash

if [ $PARROT ] || [ $KALI ]; then
    packages=("build-essential" "curl" "python-dev-is-python3" "git")
    for pkg in "${packages[@]}"; do
        sudo apt install -y $pkg
    done
elif [ $MAC ]; then
    # Haven't needed Homebrew since switching to Docker
    #/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    :
fi
