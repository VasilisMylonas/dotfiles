#!/usr/bin/env bash
set -Eeuo pipefail

install_packages() {
  sudo apt install -y syncthing syncthingtray \
    gh fzf bat htop eza neovim fd-find direnv duf ncdu fastfetch traceroute iperf3 \
    kicad kicad-packages3d yosys iverilog verilator ngspice \
    fonts-firacode fonts-ubuntu \

  systemctl enable --user syncthing
  # TODO verible
  # TODO Embedded???
  #  sudo apt install dfu-util esptool openocd picocom cmake clang clang-tools ninja ccache
  # TODO: Misc
  # sudo apt install nodejs npm golang-go
  # Snaps
  sudo snap install typst
}

install_docker() {

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
  sudo rm -f /var/run/docker.sock
  dockerd-rootless-setuptool.sh install
}

install_claude() {
  curl -fsSL https://claude.ai/install.sh | bash
}

install_starship() {
  curl -sS https://starship.rs/install.sh | sh
}

install_uv() {
  curl -LsSf https://astral.sh/uv/install.sh | sh
}

install_fonts() {
  mkdir -p ~/.local/share/fonts
  curl -L https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip -o /tmp/FiraCode.zip
  curl -L https://github.com/ryanoasis/nerd-fonts/releases/latest/download/UbuntuMono.zip -o /tmp/UbuntuMono.zip
  unzip -o /tmp/FiraCode.zip -d ~/.local/share/fonts/FiraCode
  unzip -o /tmp/UbuntuMono.zip -d ~/.local/share/fonts/UbuntuMono
  fc-cache -f
}

configure() {
  mkdir -p ~/.ssh ~/.config

  local dir
  dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

  # ssh refuses configs with unexpected ownership/permissions, so copy it
  cp "$dir/ssh-config" ~/.ssh/config
  ln -sfn "$dir/gitconfig" ~/.gitconfig
  ln -sfn "$dir/bashrc" ~/.bashrc
  ln -sfn "$dir/starship.toml" ~/.config/starship.toml

  chmod 700 ~/.ssh
  chmod 600 ~/.ssh/config
}

sudo apt update
sudo apt install -y curl timeshift build-essential python3-venv

echo "TODO: make sure to enable quota on btrfs for timeshift to show snapshot sizes"

command -v docker >/dev/null 2>&1 && echo "==> Docker already installed, skipping" || install_docker
command -v claude >/dev/null 2>&1 && echo "==> Claude already installed, skipping" || install_claude
command -v starship >/dev/null 2>&1 && echo "==> Starship already installed, skipping" || install_starship
command -v uv >/dev/null 2>&1 && echo "==> UV already installed, skipping" || install_uv
echo "==> Installing packages" && install_packages
echo "==> Installing fonts" && install_fonts

echo "==> Configuring" && configure
