#!/usr/bin/env bash

# ***** TERMINAL *****
#profile_id=$(gsettings get org.mate.terminal.global default-profile)
profile_id=default
terminal_profile="org.mate.terminal.profile:/org/mate/terminal/profiles/${profile_id}/"
# Hybrid Color Theme (http://terminal.sexy)
gsettings set $terminal_profile \
    palette "['#282a2e', '#a54242', '#8c9440', '#de935f', '#5f819d', '#85678f', '#5e8d87', '#707880', '#373b41', '#cc6666', '#b5bd68', '#f0c674', '#81a2be', '#b294bb', '#8abeb7', '#c5c8c6']"

gsettings set $terminal_profile background-color "#1d1f21"
gsettings set $terminal_profile foreground-color "#c5c8c6"
gsettings set $terminal_profile bold-color "#c5c8c6"
gsettings set $terminal_profile bold-color-same-as-fg "true"
gsettings set $terminal_profile use-theme-colors "false"
gsettings set $terminal_profile background-type "solid"
gsettings set $terminal_profile use-system-font "false"
gsettings set $terminal_profile scrollback-unlimited "true"
gsettings set $terminal_profile cursor-shape "ibeam"
gsettings set $terminal_profile allow-bold "true"

# ***** DESKTOP *****
gsettings set org.mate.screensaver idle-activation-enabled "false"
gsettings set org.mate.screensaver lock-enabled "false"
gsettings set org.mate.background picture-filename ""
gsettings set org.mate.background picture-options "wallpaper"
gsettings set org.mate.background primary-color "rgb(85,87,83)"

## PANEL
# Add frequently used apps to the top menu for quick access
# The toplevel-id is set to "top" so just hardcoding # gsettings get org.mate.panel toplevel-id-list
# Panels aren't appearing after applying and haven't found any meaninful solutions online.
### SUBLIME
# OBJECT="org.mate.panel.object:/org/mate/panel/objects/sublime/"
# gsettings set $OBJECT action-type "none"
# gsettings set $OBJECT has-arrow true
# gsettings set $OBJECT launcher-location "/usr/share/applications/sublime_text.desktop"
# gsettings set $OBJECT locked false
# gsettings set $OBJECT menu-path "applications:/"
# gsettings set $OBJECT panel-right-stick false
# gsettings set $OBJECT object-type "launcher"
# gsettings set $OBJECT position -1
# gsettings set $OBJECT toplevel-id "top"
# gsettings set $OBJECT use-custom-icon false
# gsettings set $OBJECT use-menu-path false

# ### CHERRYTREE
# OBJECT="org.mate.panel.object:/org/mate/panel/objects/cherrytree/"
# gsettings set $OBJECT action-type "none"
# gsettings set $OBJECT has-arrow true
# gsettings set $OBJECT launcher-location "/usr/share/applications/cherrytree.desktop"
# gsettings set $OBJECT locked false
# gsettings set $OBJECT menu-path "applications:/"
# gsettings set $OBJECT panel-right-stick false
# gsettings set $OBJECT object-type "launcher"
# gsettings set $OBJECT position -1
# gsettings set $OBJECT toplevel-id "top"
# gsettings set $OBJECT use-custom-icon false
# gsettings set $OBJECT use-menu-path false