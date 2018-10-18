#!/bin/bash

# Post installation script for Solus Gnome
echo "Starting post-install setup..."

# Updating system
echo "Updating system..."
sudo eopkg up
echo "System update done!"

# System software
echo "Installing system software..."
sudo eopkg it neofetch
sudo eopkg it lm_sensors
sudo eopkg it inxi

# Software
echo "Installing software..."
sudo eopkg it discord
sudo eopkg it spotify
sudo eopkg it albert
sudo eopkg it gnome-tweaks
sudo eopkg it steam
sudo eopkg it google-chrome-stable
sudo eopkg it mscorefonts
sudo eopkg it lutris
sudo eopkg it obs-studio

# Development
echo "Installing development related software..."
sudo eopkg it -c system.devel
sudo eopkg it git
sudo eopkg it vscode
sudo eopkg it nodejs
sudo eopkg it etcher

# Drivers
echo "Installing additional drivers and utility..."
sudo eopkg it razer-drivers
sudo eopkg it polychromatic

# Themes & Icons
echo "Installing themes & icons..."
sudo eopkg it arc-gtk-theme
gsettings set org.gnome.desktop.interface gtk-theme 'Arc-Dark'
sudo eopkg it papirus-icon-theme
gsettings set org.gnome.desktop.interface icon-theme 'Papirus'

# Set chrome as default browser
echo "Setting default applications..."
xdg-settings set default-web-browser google-chrome.desktop

# Disable mouse acceleration
echo "Disabling mouse acceleration..."
gsettings set org.gnome.desktop.peripherals.mouse accel-profile flat

# Update boot manager
echo "Updating boot manager..."
sudo clr-boot-manager set-timeout 0
sudo clr-boot-manager update

echo "Done!"