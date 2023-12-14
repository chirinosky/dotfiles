#!/usr/bin/env bash

# General packages to install
packages=("build-essential")

# Distribution-specific
if [ $PARROT ]; then
    packages+=("python-dev-is-python3")
else
    packages+=("pyton-dev")
fi

# Install packages
for pkg in "${packages[@]}"
    do
        sudo apt install -y $pkg
    done
