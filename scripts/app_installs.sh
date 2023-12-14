#!/usr/bin/env bash

# Install general packages
if [ $PARROT ]; then
    for pkg in build-essential python-dev-is-python3
    do
        sudo apt install -y $pkg
    done
else
    for pkg in build-essential python-dev
    do
        sudo apt install -y $pkg
    done
fi
