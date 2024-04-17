sudo pacman -S $(awk '{print $1}' pacman_pkglist.txt)
sudo yay -S $(awk '{print $1}' aur_pkglist.txt)
