#!/usr/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install pre-requisites
sudo apt update
sudo apt install -y curl timeshift build-essential python3-venv

echo "TODO: make sure to enable quota on btrfs for timeshift to show snapshot sizes"

# Install nix
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon

# Enable flakes and nix-command
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf > /dev/null

# Source the Nix profile so the shell knows about the 'nix' command right now
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

# Run home-manager
cd home-manager
nix run github:nix-community/home-manager -- switch --flake .#vasilis

# Docker
# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0754 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Root-full docker
# sudo groupadd docker
# sudo usermod -aG docker $USER
# newgrp docker
# sudo systemctl enable docker.service
# sudo systemctl enable containerd.service

# Rootless docker
sudo apt install uidmap
sudo systemctl disable --now docker.service docker.socket
sudo rm /var/run/docker.sock
dockerd-rootless-setuptool.sh install

# KiCAD
sudo apt install kicad kicad-packages3d
