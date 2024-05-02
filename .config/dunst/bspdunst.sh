#!/usr/bin/env bash

## Copyright (C) 2020-2024 Aditya Shakya <adi1090x@gmail.com>

# bspwm directory
DIR="$HOME/.config/bspwm"

# Launch dunst daemon
if [[ $(pidof dunst) ]]; then
	pkill dunst
fi

dunst -config "$DIR"/dunstrc &
