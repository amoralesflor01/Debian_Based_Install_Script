#!/bin/bash

# Log file for errors
LOG_FILE="$HOME/install_errors.log"
echo "Installation errors:" > $LOG_FILE

# Function to log and echo messages
log_and_echo() {
    echo "$1" | tee -a $LOG_FILE
}

# Update and upgrade system
log_and_echo "Updating package lists..."
sudo apt-get update -y || log_and_echo "Failed to update package list"
log_and_echo "Upgrading installed packages..."
sudo apt-get upgrade -y || log_and_echo "Failed to upgrade packages"

# Function to check if a package is installed
is_installed() {
    dpkg -l | grep -q "^ii\s*$1\s"
}

# Function to install apt-get packages
install_apt() {
    for package in "$@"; do
        if ! is_installed "$package"; then
            log_and_echo "Installing apt package: $package"
            sudo apt-get install -y "$package" || log_and_echo "Failed to install package: $package"
        else
            log_and_echo "Package $package is already installed. Skipping."
        fi
    done
}

# Function to check if a Flatpak application is installed
is_flatpak_installed() {
    flatpak list | grep -q "$1"
}

# Function to install Flatpak applications
install_flatpak() {
    for app in "$@"; do
        if ! is_flatpak_installed "$app"; then
            log_and_echo "Installing Flatpak app: $app"
            flatpak install -y flathub "$app" || log_and_echo "Failed to install Flatpak app: $app"
        else
            log_and_echo "Flatpak app $app is already installed. Skipping."
        fi
    done
}

# List of apt packages to install
APT_PACKAGES=(
    "pip"
    "curl"
    "vim"
    "tmux"
    "xclip"
    "neofetch"
    "net-tools"
    #"macchanger"
    "exfat-utils"
    #"converseen"
    #"soundconverter"
    "git"
    "htop"
    #"gpa"
    "ffmpeg"
)

# List of Flatpak apps to install
FLATPAK_APPS=(
    "org.keepassxc.KeePassXC"
    "com.bitwarden.desktop"
    #"org.kde.kleopatra"
    "org.qbittorrent.qBittorrent"
    "com.obsproject.Studio"
    "org.signal.Signal"
    "org.videolan.VLC"
    "com.github.tchx84.Flatseal"
    "io.freetubeapp.FreeTube"
    "org.standardnotes.standardnotes"
    "com.brave.Browser"
    "org.cryptomator.Cryptomator"
    "flatpak install flathub org.gnome.Rhythmbox3"
    "flatpak install flathub net.fasterland.converseen"
    "flatpak install flathub org.soundconverter.SoundConverter"
    # "org.raspberrypi.rpi-imager"
    # "org.gimp.GIMP"
    # "org.audacityteam.Audacity"
    # "io.atom.Atom"
    "us.zoom.Zoom"
    # "org.onionshare.OnionShare"
)

# Install apt packages
install_apt "${APT_PACKAGES[@]}"

# Install Flatpak applications
install_flatpak "${FLATPAK_APPS[@]}"

# Clean up
log_and_echo "Cleaning up unnecessary packages..."
sudo apt-get autoremove -y || log_and_echo "Failed to autoremove packages"
sudo apt-get autoclean || log_and_echo "Failed to clean up"

log_and_echo "All installations are complete! Check $LOG_FILE for any errors."
