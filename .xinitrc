#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then

	xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
	xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then

	xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
	xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ]; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

# WM
wm=xmonad

setxkbmap -layout us,ir -option grp:win_space_toggle &
light -S 85
# setxkbmap -layout us,ir -option grp:alt_shift_toggle &
# picom &
killall trayer
sleep 2 && trayer --edge top --align right --widthtype request --SetDockType true --SetPartialStrut true \
	--expand true --transparent true --alpha 0 --tint 0x000000 --height 40 &
feh --bg-scale ~/wallpapers/Plant-Onions.png
xsetroot -cursor_name left_ptr

# Exec WM
exec "$wm"
