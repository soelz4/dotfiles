#!/bin/env bash
#  ██████╗ ██╗ ██████╗███████╗    ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ███████╗██████╗
#  ██╔══██╗██║██╔════╝██╔════╝    ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔════╝██╔══██╗
#  ██████╔╝██║██║     █████╗      ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     █████╗  ██████╔╝
#  ██╔══██╗██║██║     ██╔══╝      ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══╝  ██╔══██╗
#  ██║  ██║██║╚██████╗███████╗    ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗███████╗██║  ██║
#  ╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝    ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝
#  Script to Install my Dotfiles
#  Author: soelz4
#  url: https://github.com/soelz4/dotfiles

# Welcome
echo "Welcome to the Rice Installer" && sleep 2

# System Update and Install some Basic Package
echo "Doing a System Update, Cause Stuff may Break if it's not the Latest Version..."
sudo pacman --noconfirm -Syyu artix-keyring archlinux-keyring

# AUR Helper - Default Value = yay
HELPER="yay"

# Install Packages from Official Repository
echo "Install Packages from Official Repository ..." && sleep 2
sudo pacman -S $(awk '{print $1}' pacman_pkglist.txt)

# im Using Artix Runit Sysytem Init so i Need to RUN this Command
# if You Use Other System init you Must link it in Your Own Way
# and if you use Systemd Skip this Step and Comment it
sudo ln -s /etc/runit/sv/git-daemon/ /run/runit/service/
sudo ln -s /etc/runit/sv/alsa/ /run/runit/service/

# Initialize AUR Helper
echo "We Need an AUR Helper. It is Essential.  1) paru  2) yay"
read -r -p "What is the AUR Helper of your Choice? (Default is yay): " num
if [ "$num" -eq 2 ]; then
	HELPER="paru"
fi

# Install AUR Helper if You Don't have $HELPER Installed
if ! command -v $HELPER &>/dev/null; then
	echo "It seems that you don't have $HELPER Installed, I'll Install that for you Before Continuing."
	git clone https://aur.archlinux.org/$HELPER.git ~/Downloads/$HELPER
	(cd ~/Downloads/$HELPER/ && makepkg -si)
fi

# Install Packages from AUR Repository
echo "Install Packages from AUR Repository ..." && sleep 2
"$HELPER" -S $(awk '{print $1}' aur_pkglist.txt)

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

# Install tmuxifier
git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier

# install TMUX TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install Vim Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install Pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle &&
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Copy Wallpapers Directory to Home Directory
mkdir ~/wallpapers/
cp -r ./wallpapers/* "$HOME"/wallpapers/

# Copy Some Configs into Home Directory
cp .vimrc \
	.tmux.conf \
	.fzf.bash \
	.bashrc \
	.xinitrc \
	.Xresources \
	"$HOME"

# Make Directory .config
mkdir -p ~/.config/

# Rofi
if [ -d ~/.config/rofi/ ]; then
	echo "Rofi Configs Detected, Backing Up and Then Installing ..."
	mkdir ~/.config/rofi.backup/ && mv ~/.config/rofi/* ~/.config/rofi.backup/
	cp -r ./.config/rofi/* ~/.config/rofi/
else
	echo "Installing Rofi Configs..."
	mkdir ~/.config/rofi/ && cp -r ./.config/rofi/* ~/.config/rofi
fi

sleep 2

# Picom
if [ -f ~/.config/picom/picom.conf ]; then
	echo "Picom Configs Detected, Backing Up and Then Installing ..."
	cp ~/.config/picom/picom.conf ~/.config/picom/picom.conf.backup
	cp ./.config/picom/picom.conf ~/.config/picom/picom.conf
else
	echo "Installing Picom Configs..."
	mkdir ~/.config/picom/ && cp ./.config/picom/picom.conf ~/.config/picom/picom.conf
fi

sleep 2

# WezTerm
if [ -f ~/.config/wezterm/wezterm.lua ]; then
	echo "WezTerm Configs Detected, Backing Up and Then Installing ..."
	cp ~/.config/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua.backup
	cp ./.config/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
else
	echo "Installing WezTerm Configs..."
	mkdir ~/.config/wezterm/ && cp ./.config/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
fi

sleep 2

# PolyBar
if [ -d ~/.config/polybar/ ]; then
	echo "PolyBar Configs Detected, Backing Up and Then Installing ..."
	mkdir ~/.config/polybar.backup/ && mv ~/.config/polybar/* ~/.config/polybar.backup/
	cp -r ./.config/polybar/* ~/.config/polybar/
else
	echo "Installing PolyBar Configs..."
	mkdir ~/.config/polybar/ && cp -r ./.config/polybar/* ~/.config/polybar/
fi

sleep 2

# TMUX
if [ -d ~/.config/tmux/ ]; then
	echo "TMUX Configs Detected, Backing Up and Then Installing ..."
	mkdir ~/.config/tmux.backup/ && mv ~/.config/tmux/* ~/.config/tmux.backup/
	cp -r ./.config/tmux/* ~/.config/tmux/
else
	echo "Installing TMUX Configs..."
	mkdir ~/.config/tmux/ && cp -r ./.config/tmux/* ~/.config/tmux/
fi

sleep 2

# BSPWM
if [ -d ~/.config/bspwm/ ]; then
	echo "BSPWM Configs Detected, Backing Up and Then Installing ..."
	mkdir ~/.config/bspwm.backup/ && mv ~/.config/bspwm/* ~/.config/bspwm.backup/
	cp -r ./.config/bspwm/* ~/.config/bspwm/
else
	echo "Installing BSPWM Configs..."
	mkdir ~/.config/bspwm/ && cp -r ./.config/bspwm/* ~/.config/bspwm/
fi

sleep 2

# SXHKD
if [ -d ~/.config/sxhkd/ ]; then
	echo "SXHKD Configs Detected, Backing Up and Then Installing ..."
	mkdir ~/.config/sxhkd.backup/ && mv ~/.config/sxhkd/* ~/.config/sxhkd.backup/
	cp -r ./.config/sxhkd/* ~/.config/sxhkd/
else
	echo "Installing SXHKD Configs..."
	mkdir ~/.config/sxhkd/ && cp -r ./.config/sxhkd/* ~/.config/sxhkd/
fi

sleep 2

# Fish
if [ -d ~/.config/fish/ ]; then
	echo "Fish Configs Detected, Backing Up and Then Installing ..."
	mkdir ~/.config/fish.backup/ && mv ~/.config/fish/* ~/.config/fish.backup/
	cp -r ./.config/fish/* ~/.config/fish/
else
	echo "Installing Fish Configs..."
	mkdir ~/.config/fish/ && cp -r ./.config/fish/* ~/.config/fish/
fi

sleep 2

# Conky
if [ -d ~/.config/conky/ ]; then
	echo "Conky Configs Detected, Backing Up and Then Installing ..."
	mkdir ~/.config/conky.backup/ && mv ~/.config/conky/* ~/.config/conky.backup/
	cp -r ./.config/conky/* ~/.config/conky/
else
	echo "Installing Conky Configs..."
	mkdir ~/.config/conky/ && cp -r ./.config/conky/* ~/.config/conky/
fi

sleep 2

# jgmenu
if [ -d ~/.config/jgmenu/ ]; then
	echo "jgmenu Configs Detected, Backing Up and Then Installing ..."
	mkdir ~/.config/jgmenu.backup/ && mv ~/.config/jgmenu/* ~/.config/jgmenu.backup/
	cp -r ./.config/jgmenu/* ~/.config/jgmenu/
else
	echo "Installing jgmenu Configs..."
	mkdir ~/.config/jgmenu/ && cp -r ./.config/jgmenu/* ~/.config/jgmenu/
fi

sleep 2

# NeoVim
if [ -d ~/.config/nvim/ ]; then
	echo "NeoVim Configs Detected, Backing Up and Then Installing ..."
	mkdir ~/.config/nvim.backup/ && mv ~/.config/nvim/* ~/.config/nvim.backup/
	cp -r ./.config/nvim/* ~/.config/nvim/
else
	echo "Installing NeoVim Configs..."
	mkdir ~/.config/nvim/ && cp -r ./.config/nvim/* ~/.config/nvim/
fi

sleep 2
