# Debian Based Program Install Script
This BASH script allows users to fill in whichever **APT** and **FLATPAK** packages they use and automates the installation of those apps to save Linux users time installing programs after a fresh install of Debian-based Linux Distros.

1. First install and set up Flathub for your distro of choice (if not already installed):

	**[Flathub Setup](https://flathub.org/setup)**

2. For **FLATPAKS** locate the ***Application ID*** of the app you want, paste it after the '*install_flatpak*' function the script for flatpak apps with quotes. 

	- Example (For KeePassXC)

	```install_flatpak "org.keepassxc.KeePassXC"```

3. For **APT** packages, simply place quotes around the package you wish to install. Then place it after of the '*install_apt*' function of the script.

	- Example (for TMUX): 

	```install_apt "tmux"```

4. If you look at the code, there are examples of how to do this and some packages I use so remove what you do not need and add whatever you wish once you clone the repo.
