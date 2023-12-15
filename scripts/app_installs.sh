#!/usr/bin/env bash

# General packages to install
packages=("build-essential" "curl")

# Distribution-specific
if [ $PARROT ] || [ $KALI ]; then
    packages+=("python-dev-is-python3")
else
    packages+=("python-dev")
fi

# Install packages
for pkg in "${packages[@]}"; do
    sudo apt install -y $pkg
done

if [ $KALI ]; then
    # Remove the annoying screen lock
    sudo apt remove -y light-locker
fi
