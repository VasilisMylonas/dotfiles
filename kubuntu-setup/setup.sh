#!/usr/bin/bash

# Install nix
sudo apt install curl timeshift
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon

# TODO: update nix config file to allow nix profile

# Install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manage
nix-channel --update
nix-shell '<home-manager>' -A install

home-manager switch

# FIX for Kubuntu: make desktop files executable
find ~/.nix-profile/share/applications/ -iname '*.desktop' | xargs -n 1 readlink | sudo xargs chmod +x

# Purge snap
sudo apt purge -y snapd

# Install real firefox
sudo add-apt-repository -y ppa:mozillateam/ppa
sudo apt update
cat <<EOF | sudo tee /etc/apt/preferences.d/mozillateamppa > /dev/null
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
EOF
sudo apt install -y firefox
sudo apt-mark hold firefox

# Codecs
sudo apt install libavcodec-extra -y
