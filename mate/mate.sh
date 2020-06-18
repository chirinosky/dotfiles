#!/usr/bin/env bash

# Available Settings
# gsettings list-relocatable-schemas |grep -i terminal
#       org.gnome.Terminal.SettingsList
#       org.gnome.Terminal.Legacy.Profile
#       org.gnome.Terminal.Legacy.Keybindings
# 
# Listing settings for schema: gsettings list-keys org.gnome.Terminal.Legacy.Profile
#       foreground-color                                                                                                                                                                        
#       highlight-foreground-color                                                                                                                                                              
#       word-char-exceptions                                                                                                                                                                    
#       audible-bell                                                                                                                                                                            
#       palette
#       ...
#
# Get a particular value for setting
# gsettings get org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${profile}/ palette
#       ['#282a2e', '#a54242', '#8c9440', '#de935f', '#5f819d', '#85678f', '#5e8d87', '#707880', '#373b41', '#cc6666', '#b5bd68', '#f0c674', '#81a2be', '#b294bb', '#8abeb7', '#c5c8c6']

# ***** TERMINAL *****
# uuid=$(gsettings get org.gnome.Terminal.ProfilesList default)
# uuid=${uuid:1:-1}
# terminal_profile="org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${uuid}/"
profile_id = (gsettings get org.mate.terminal.global default-profile)
terminal_profile="org.mate.terminal.profile:/org/mate/terminal/profiles/${profile_id}/"
# Hybrid Color Theme (http://terminal.sexy)
gsettings set $terminal_profile \
    palette "['#282a2e', '#a54242', '#8c9440', '#de935f', '#5f819d', '#85678f', '#5e8d87', '#707880', '#373b41', '#cc6666', '#b5bd68', '#f0c674', '#81a2be', '#b294bb', '#8abeb7', '#c5c8c6']"
gsettings set $terminal_profile background-color "#1d1f21"
gsettings set $terminal_profile foreground-color "#c5c8c6"
gsettings set $terminal_profile bold-color "#c5c8c6"
gsettings set $terminal_profile bold-color-same-as-fg "true"
gsettings set $terminal_profile use-theme-colors "false"
gsettings set $terminal_profile encoding "UTF-8"
gsettings set $terminal_profile scrollback-unlimited "true"
gsettings set $terminal_profile cursor-shape "ibeam"
gsettings set $terminal_profile cursor-colors-set "true"
gsettings set $terminal_profile cursor-foreground-color "#7592B2"
gsettings set $terminal_profile cursor-background-color "#7592B2"
gsettings set $terminal_profile use-transparent-background "false"
gsettings set $terminal_profile bold-is-bright "true"
gsettings set $terminal_profile allow-bold "true"
gsettings set $terminal_profile rewrap-on-resize "true"

# # ***** DESKTOP *****
# gnome-extensions enable window-list@gnome-shell-extensions.gcampax.github.com
# gnome-extensions disable dash-to-dock@micxgx.gmail.com
# gsettings set org.gnome.desktop.privacy remove-old-temp-files "true"
# gsettings set org.gnome.desktop.privacy remove-old-trash-files "true"
# gsettings set org.gnome.desktop.privacy old-files-age "uint32 30"
# gsettings set org.gnome.desktop.screensaver lock-enabled "false"
# gsettings set org.gnome.shell.extensions.window-list show-on-all-monitors "true"
# gsettings set org.gnome.shell.extensions.window-list grouping-mode "never"

# ***** MATE ******
# profile_id = (gsettings get org.mate.terminal.global default-profile)
# terminal_profile="org.mate.terminal.profile:/org/mate/terminal/profiles/${profile_id}/"
