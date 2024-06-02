#!/usr/bin/env bash

# bspwm directory
DIR="$HOME/.config/bspwm"

# Launch dunst daemon
if [[ $(pidof dunst) ]]; then
	pkill dunst
fi

dunst -config ~/.config/dunst/dunstrc
