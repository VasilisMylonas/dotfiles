#!/usr/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Install pre-requisites
sudo apt update
sudo apt install -y curl timeshift

# TODO: make sure to enable quota on btrfs for timeshift to show snapshot sizes

# Install nix
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon

# Enable flakes and nix-command
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf > /dev/null

# Source the Nix profile so the shell knows about the 'nix' command right now
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi

cd home-manager
nix run github:nix-community/home-manager -- switch --flake .#vasilis
