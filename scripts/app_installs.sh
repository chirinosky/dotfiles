#!/usr/bin/env bash

# Install general packages
apt update
for pkg in build-essential python-dev
do
    apt install -y $pkg
done