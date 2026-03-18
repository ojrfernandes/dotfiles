#!/bin/bash

# Install official packages
sudo pacman -S --needed - < pkglist.txt

# Install AUR helper
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si

# Install AUR packages
yay -S --needed - < pkglist-aur.txt

# Enable system services
while read service; do
  sudo systemctl enable "$service" 2>/dev/null
done < services.txt

# Enable user services
while read service; do
  systemctl --user enable "$service" 2>/dev/null
done < user-services.txt
