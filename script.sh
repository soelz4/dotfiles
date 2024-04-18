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
cp -r ./wallpapers/ "$HOME"

# Copy Some Configs into Home Directory
cp .vimrc \
	.tmux.conf \
	.fzf.bash \
	.bashrc \
	.xinitrc \
	.Xresources \
	"$HOME"

# Copy Dotfiles into .config Directory
cp -r .config/* ~/.config/
