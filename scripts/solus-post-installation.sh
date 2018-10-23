#!/bin/bash

# Post installation script for Solus Gnome
echo "Starting post-install setup..."

# Updating system
echo "Updating system..."
sudo eopkg -y up
echo "System update done!"

# System software
echo "Installing system software..."
sudo eopkg it -y neofetch
sudo eopkg it -y lm_sensors
sudo eopkg it -y inxi

# Software
echo "Installing software..."
sudo eopkg it -y discord
sudo eopkg it -y gnome-tweaks
sudo eopkg it -y steam
sudo eopkg it -y mscorefonts
sudo eopkg it -y lutris
sudo eopkg it -y obs-studio

# 3rd party software
echo "Installing Google Chrome..."
sudo eopkg bi -y --ignore-safety https://raw.githubusercontent.com/solus-project/3rd-party/master/network/web/browser/google-chrome-stable/pspec.xml
sudo eopkg it -y google-chrome-*.eopkg
sudo rm google-chrome-*.eopkg

echo "Installing Spotify..."
sudo eopkg bi -y --ignore-safety https://raw.githubusercontent.com/solus-project/3rd-party/master/multimedia/music/spotify/pspec.xml
sudo eopkg it -y spotify*.eopkg
sudo rm spotify*.eopkg

# Dependencies for running Battle.net games in Lutris
echo "Installing mscorefonts..."
sudo eopkg bi -y --ignore-safety https://raw.githubusercontent.com/solus-project/3rd-party/master/desktop/font/mscorefonts/pspec.xml
sudo eopkg it -y mscorefonts*.eopkg
sudo rm mscorefonts*.eopkg

echo "Installing dependencies for Bnet games running with Lutris..."
sudo eopkg it -y libgnutls libgnutls-devel libgnutls-32bit libgnutls-32bit-devel openldap-devel openldap-32bit-devel libgpg-error-devel libgpg-error-32bit libgpg-error-32bit-devel sqlite3 sqlite3-32bit

# Development
echo "Installing development related software..."
sudo eopkg it -y -c system.devel
sudo eopkg it -y git
sudo eopkg it -y vscode
sudo eopkg it -y nodejs
sudo eopkg it -y etcher

# Drivers
echo "Installing additional drivers and utility..."
sudo eopkg it -y razer-drivers
sudo eopkg it -y polychromatic
sudo eopkg it -y piper

# Themes & Icons
echo "Installing themes & icons..."
sudo eopkg it -y arc-gtk-theme
gsettings set org.gnome.desktop.interface gtk-theme 'Arc-Dark'
sudo eopkg it -y papirus-icon-theme
gsettings set org.gnome.desktop.interface icon-theme 'Papirus'

# Set chrome as default browser
echo "Setting default applications..."
xdg-settings set default-web-browser google-chrome.desktop

# Disable mouse acceleration
echo "Disabling mouse acceleration..."
gsettings set org.gnome.desktop.peripherals.mouse accel-profile flat

# Disabling screensaver
echo "Disabling screensaver..."
gsettings set org.gnome.desktop.session idle-delay 0

# Disabling workspaces
echo "Disabling workspaces..."
gsettings set org.gnome.shell.overrides dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 1

# Update boot manager
echo "Updating boot manager..."
sudo clr-boot-manager set-timeout 0
sudo clr-boot-manager update

echo
echo "Done!"
echo

echo "A reboot is recommended at this point."
read -p "Do you want to reboot? (yes/no)" -r
echo
if [[ $REPLY =~ ^[Yy][Ee][Ss]$ ]]
then
  systemctl reboot -i
else
	echo "You choose not to reboot, things may not work as expected until you do."
fi