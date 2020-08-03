#!/bin/bash

# Keyboard configuration in Xorg.
# https://wiki.archlinux.org/index.php/Xorg/Keyboard_configuration

# Change the default "X" shaped cursor to the arrow cursor.
xsetroot -cursor_name left_ptr

# Speed up the key autorepeat.
# The first is a repeat delay (default 660), the second is a repeat rate (default 25).
# Display the current settings:
#   xset -q
# Reset:
#   xset r rate
xset r rate 300 50

# KEYBOARD MAPPINGS
# man xkeyboard-config
# Print the current config:
#   setxkbmap -query
# Reset options:
#   setxkbmap -option
# Caps Lock as an additional Left Super.
setxkbmap -option "caps:super"
# Menu as Right Ctrl.
setxkbmap -option "ctrl:menu_rctrl"
# Right Ctrl as Right Super.
setxkbmap -option "ctrl:swap_rwin_rctl"

# Make Caps Lock generate Escape when pressed and released on it's own.
xcape -e 'Super_L=Escape'

# Start the window manager.
# exec bspwm
