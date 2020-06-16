#!/usr/bin/env bash

# Install general packages
for pkg in build-essential python-dev
do
    sudo apt install -y $pkg
done
