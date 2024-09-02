# Debian_Based_Install_Script
This BASH script allows users to fill in the apt-get and flathub packages and automates the installs to save Linux users time installing programs after a fresh install of Debian-based Linux Distros.

Just make sure to install Flathub first for your distro:

	https://flathub.org/setup

Then locate the name of the Application ID of the app you want, paste it into the install section for flatpak apps with quotes. Example: "org.keepassxc.KeePassXC" (for KeePassXC). Do the same for APT packages.

If you look at the code, there are examples of how to do this and some packages I use so remove what you do not need and add whatever you wish once you clone the repo.
