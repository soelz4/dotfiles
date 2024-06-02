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

# colors
black=$(tput setaf 0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
purple=$(tput setaf 5)
cyan=$(tput setaf 6)
whilte=$(tput setaf 7)
default=$(tput setaf 9)
reset=$(tput sgr0)

# Welcome
echo "${green}Welcome to the Rice Installer${reset}" && sleep 2

# System Update and Install some Basic Package
echo "${green}Doing a System Update, Cause Stuff may Break if it's not the Latest Version...${reset}"
sudo pacman --noconfirm -Syyu artix-keyring archlinux-keyring

# AUR Helper - Default Value = yay
HELPER="yay"

echo "${red}______________________${reset}"
# Install Packages from Official Repository
echo "${green}Install Packages from Official Repository ...${reset}" && sleep 2
sudo pacman -S $(awk '{print $1}' pacman_pkglist.txt)

echo "${red}______________________${reset}"
# im Using Artix Runit Sysytem Init so i Need to RUN this Command
# if You Use Other System init you Must link it in Your Own Way
# and if you use Systemd Skip this Step and Comment it
echo "${green}Link the Service Directories into the Desired RUN Level Directory${reset}"
sudo ln -s /etc/runit/sv/git-daemon/ /run/runit/service/
sudo mkdir -p /srv/git
sudo ln -s /etc/runit/sv/alsa/ /run/runit/service/
sudo ln -s /etc/runit/sv/docker/ /run/runit/service/
sudo ln -s /etc/runit/sv/postgresql/ /run/runit/service/
sudo ln -s /etc/runit/sv/redis/ /run/runit/service/

echo "${red}______________________${reset}"
# Initialize AUR Helper
echo "${green}AUR HELPER${reset}"
echo "${green}We Need an AUR Helper. It is Essential.  1) yay  2) paru${reset}"
read -r -p "What is the AUR Helper of your Choice? (Default is yay): " num
if [ "$num" -eq 2 ]; then
	HELPER="paru"
fi

# Install AUR Helper if You Don't have $HELPER Installed
if ! command -v $HELPER &>/dev/null; then
	echo "${green}It seems that you don't have $HELPER Installed, I'll Install that for you Before Continuing.${reset}"
	git clone https://aur.archlinux.org/$HELPER.git ~/Downloads/$HELPER
	(cd ~/Downloads/$HELPER/ && makepkg -si)
fi

echo "${red}______________________${reset}"
# Install Packages from AUR Repository
echo "${green}Install Packages from AUR Repository ...${reset}" && sleep 2
"$HELPER" -S $(awk '{print $1}' aur_pkglist.txt)

echo "${red}______________________${reset}"
# Copy Wallpapers Directory to Home Directory
echo "${green}Copy Wallpapers into Your ~/wallpapers/ Directory${reset}"
mkdir ~/wallpapers/
cp -r ./wallpapers/* "$HOME"/wallpapers/

echo "${red}______________________${reset}"
# Copy Some Configs into Home Directory
echo "${green}Copy Some Configs into Home Directory${reset}"
cp .vimrc \
	.tmux.conf \
	.bashrc \
	.xinitrc \
	.Xresources \
	"$HOME"

echo "${red}______________________${reset}"
# Make Directory .config
echo "${green}Create ~/.config/ Directory${reset}"
mkdir -p ~/.config/

echo "${red}______________________${reset}"
# Rofi
if [ -d ~/.config/rofi/ ]; then
	echo "${green}Rofi Configs Detected, Backing Up and Then Installing ...${reset}"
	mkdir ~/.config/rofi.backup/ && mv ~/.config/rofi/* ~/.config/rofi.backup/
	cp -r ./.config/rofi/* ~/.config/rofi/
else
	echo "${green}Installing Rofi Configs...${reset}"
	mkdir ~/.config/rofi/ && cp -r ./.config/rofi/* ~/.config/rofi
fi

sleep 2

# Picom
if [ -f ~/.config/picom/picom.conf ]; then
	echo "${green}Picom Configs Detected, Backing Up and Then Installing ...${reset}"
	cp ~/.config/picom/picom.conf ~/.config/picom/picom.conf.backup
	cp ./.config/picom/picom.conf ~/.config/picom/picom.conf
else
	echo "${green}Installing Picom Configs...${reset}"
	mkdir ~/.config/picom/ && cp ./.config/picom/picom.conf ~/.config/picom/picom.conf
fi

sleep 2

# WezTerm
if [ -f ~/.config/wezterm/wezterm.lua ]; then
	echo "${green}WezTerm Configs Detected, Backing Up and Then Installing ...${reset}"
	cp ~/.config/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua.backup
	cp ./.config/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
else
	echo "${green}Installing WezTerm Configs...${reset}"
	mkdir ~/.config/wezterm/ && cp ./.config/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
fi

sleep 2

# PolyBar
if [ -d ~/.config/polybar/ ]; then
	echo "${green}PolyBar Configs Detected, Backing Up and Then Installing ...${reset}"
	mkdir ~/.config/polybar.backup/ && mv ~/.config/polybar/* ~/.config/polybar.backup/
	cp -r ./.config/polybar/* ~/.config/polybar/
else
	echo "${green}Installing PolyBar Configs...${reset}"
	mkdir ~/.config/polybar/ && cp -r ./.config/polybar/* ~/.config/polybar/
fi

sleep 2

# TMUX
if [ -d ~/.config/tmux/ ]; then
	echo "${green}TMUX Configs Detected, Backing Up and Then Installing ...${reset}"
	mkdir ~/.config/tmux.backup/ && mv ~/.config/tmux/* ~/.config/tmux.backup/
	cp -r ./.config/tmux/* ~/.config/tmux/
else
	echo "${green}Installing TMUX Configs...${reset}"
	mkdir ~/.config/tmux/ && cp -r ./.config/tmux/* ~/.config/tmux/
fi

sleep 2

# BSPWM
if [ -d ~/.config/bspwm/ ]; then
	echo "${green}BSPWM Configs Detected, Backing Up and Then Installing ...${reset}"
	mkdir ~/.config/bspwm.backup/ && mv ~/.config/bspwm/* ~/.config/bspwm.backup/
	cp -r ./.config/bspwm/* ~/.config/bspwm/
else
	echo "${green}Installing BSPWM Configs...${reset}"
	mkdir ~/.config/bspwm/ && cp -r ./.config/bspwm/* ~/.config/bspwm/
fi

sleep 2

# DWM
echo "${green}Installing SUCKLESS (DWM, ST, DMENU, SLSTATUS) into ~> ~/.config/suckless/ Directory${reset}"
if [ -d ~/.config/suckless/ ]; then
	echo "${green}DWM Configs Detected, Backing Up and Then Installing ...${reset}"
	mkdir ~/.config/suckless.backup/ && mv ~/.config/suckless/* ~/.config/suckless.backup/
	cp -r ./.config/suckless/* ~/.config/suckless/
else
	echo "${green}Installing DWM Configs...${reset}"
	mkdir ~/.config/suckless/ && cp -r ./.config/suckless/* ~/.config/suckless/
fi

# sudo touch /etc/modules-load.d/modules.conf && echo "snd-pcm-oss" | sudo tee /etc/modules-load.d/modules.conf
echo "${green}SUCKLESS ~> All the Files are Inside the ~/.config/suckless/ Directory.${reset}"
echo "${green}SUCKLESS ~> to Install Each of them, go to the Desired Directory and Run the \"sudo make clean isntall\" Command${reset}"

sleep 2

# SXHKD
if [ -d ~/.config/sxhkd/ ]; then
	echo "${green}SXHKD Configs Detected, Backing Up and Then Installing ...${reset}"
	mkdir ~/.config/sxhkd.backup/ && mv ~/.config/sxhkd/* ~/.config/sxhkd.backup/
	cp -r ./.config/sxhkd/* ~/.config/sxhkd/
else
	echo "${green}Installing SXHKD Configs...${reset}"
	mkdir ~/.config/sxhkd/ && cp -r ./.config/sxhkd/* ~/.config/sxhkd/
fi

sleep 2

# Fish
if [ -f ~/.config/fish/config.fish ]; then
	echo "${green}Fish Configs Detected, Backing Up and Then Installing ...${reset}"
	mv ~/.config/fish/config.fish ~/.config/fish/config.fish.backup
	cp ./.config/fish/config.fish ~/.config/fish/
else
	echo "${green}Installing Fish Configs...${reset}"
	if [ -d ~/.config/fish/ ]; then
		cp ./.config/fish/config.fish ~/.config/fish/
	else
		mkdir ~/.config/fish && cp ./.config/fish/config.fish ~/.config/fish/
	fi
fi

sleep 2

# NeoVim
if [ -d ~/.config/nvim/ ]; then
	echo "${green}NeoVim Configs Detected, Backing Up and Then Installing ...${reset}"
	mkdir ~/.config/nvim.backup/ && mv ~/.config/nvim/* ~/.config/nvim.backup/
	cp -r ./.config/nvim/* ~/.config/nvim/
else
	echo "${green}Installing NeoVim Configs...${reset}"
	mkdir ~/.config/nvim/ && cp -r ./.config/nvim/* ~/.config/nvim/
fi

sleep 2

# Dunst
if [ -d ~/.config/dunst/ ]; then
	echo "${green}Dunst Configs Detected, Backing Up and Then Installing ...${reset}"
	mkdir ~/.config/dunst.backup/ && mv ~/.config/dunst/* ~/.config/dunst.backup/
	cp -r ./.config/dunst/* ~/.config/dunst/
else
	echo "${green}Installing Dunst Configs...${reset}"
	mkdir ~/.config/dunst/ && cp -r ./.config/dunst/* ~/.config/dunst/
fi

sleep 2

echo "${red}______________________${reset}"
# Install fzf
echo "${green}Installing FuzzyFinder${reset}"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo "${red}______________________${reset}"
# Install tmuxifier
echo "${green}Installing Tmuxifier${reset}"
git clone https://github.com/jimeh/tmuxifier.git ~/.tmuxifier

echo "${red}______________________${reset}"
# install TMUX TPM
echo "${green}Installing TMUX TPM${reset}"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "${red}______________________${reset}"
# Install Vim Plug
echo "${green}Installing Vim Plug${reset}"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "${red}______________________${reset}"
# Install Pathogen
echo "${green}Installing Pathogen${reset}"
mkdir -p ~/.vim/autoload ~/.vim/bundle &&
	curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

echo "${red}______________________${reset}"
# Install Deno
echo "${green}Installing Deno${reset}"
curl -fsSL https://deno.land/install.sh | sh

echo "${red}______________________${reset}"
# Install Rust
echo "${green}Installing Rust${reset}"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
