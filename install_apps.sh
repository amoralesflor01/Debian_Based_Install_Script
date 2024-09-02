#!/bin/bash

# Log file for errors
LOG_FILE="install_errors.log"
echo "Installation errors:" > $LOG_FILE

# Update and upgrade system
#sudo apt-get update && sudo apt-get dist-upgrade -y || echo "Failed to update package list AND full dist-upgrade" >> $LOG_FILE
sudo apt-get update -y || echo "Failed to update package list" >> $LOG_FILE
sudo apt-get upgrade -y || echo "Failed to upgrade packages" >> $LOG_FILE

# Install required dependencies
#sudo apt-get install -y software-properties-common apt-transport-https curl || echo "Failed to install dependencies" >> $LOG_FILE

# Function to check if a package is installed
is_installed() {
    dpkg -l | grep -q "^ii\s*$1\s"
}

# Function to add PPAs and install packages
#install_ppa() {
#    sudo add-apt-repository -y ppa:$1 || { echo "Failed to add PPA: $1" >> $LOG_FILE; return; }
#    sudo apt-get update -y || { echo "Failed to update after adding PPA: $1" >> $LOG_FILE; return; }
#    if ! is_installed $2; then
#        sudo apt-get install -y $2 || echo "Failed to install package from PPA: $2" >> $LOG_FILE
#    else
#        echo "Package $2 is already installed. Skipping."
#    fi
#}

# Function to install apt-get packages
install_apt() {
    if ! is_installed $1; then
        sudo apt-get install -y $1 || echo "Failed to install package: $1" >> $LOG_FILE
    else
        echo "Package $1 is already installed. Skipping."
    fi
}

# Function to check if a Flatpak application is installed
is_flatpak_installed() {
    flatpak list | grep -q "$1"
}

# Function to install Flatpak applications
install_flatpak() {
    if ! is_flatpak_installed $1; then
        flatpak install -y flathub $1 || echo "Failed to install Flatpak app: $1" >> $LOG_FILE
    else
        echo "Flatpak app $1 is already installed. Skipping."
    fi
}

# Add PPAs and install applications
#install_ppa "ppa:deadsnakes/ppa" "python3.9"
#install_ppa "ppa:obsproject/obs-studio" "obs-studio"

# Install apt-get packages
install_apt "pip"
install_apt "curl"
install_apt "vim"
install_apt "tmux"
install_apt "xclip"
install_apt "neofetch"
install_apt "net-tools"
install_apt "macchanger"
install_apt "exfat-utils"
install_apt "converseen"
install_apt "soundconverter"
install_apt "git"
install_apt "htop"
install_apt "gpa"
install_apt "ffmpeg"

# Install Flatpak applications
install_flatpak "org.keepassxc.KeePassXC"
install_flatpak "com.bitwarden.desktop"
install_flatpak "org.kde.kleopatra"
install_flatpak "org.qbittorrent.qBittorrent"
#install_flatpak "me.kozec.syncthingtk"
#install_flatpak "org.raspberrypi.rpi-imager"
install_flatpak "com.obsproject.Studio"
install_flatpak "org.signal.Signal"
install_flatpak "org.videolan.VLC"
install_flatpak "com.github.tchx84.Flatseal"
install_flatpak "io.freetubeapp.FreeTube"
install_flatpak "org.standardnotes.standardnotes"
#install_flatpak "org.gimp.GIMP"
#install_flatpak "org.audacityteam.Audacity"
#install_flatpak "io.atom.Atom"
install_flatpak "com.brave.Browser"
install_flatpak "org.cryptomator.Cryptomator"
#install_flatpak "us.zoom.Zoom"
#install_flatpak "org.onionshare.OnionShare"

# Clean up
sudo apt-get autoremove -y || echo "Failed to autoremove packages" >> $LOG_FILE
sudo apt-get clean || echo "Failed to clean" >> $LOG_FILE

echo "All installations are complete! Check $LOG_FILE for any errors."

