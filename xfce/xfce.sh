#!/usr/bin/env bash

if [ $KALI ]; then
    # Remove the annoying screen lock
    sudo apt remove -y light-locker
fi
