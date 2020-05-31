#!/usr/bin/env bash

# Install general packages
sudo apt update
for pkg in build-essential python-dev
do
    sudo apt install -y $pkg
done
