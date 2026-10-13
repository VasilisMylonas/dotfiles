#!/usr/bin/env bash
# Sets up the University of Patras VPN as a NetworkManager profile ("UPatras VPN").
#
# Needs the .ovpn config from the uni portal (login required):
#   https://mussa.upnet.gr/user/index.php?action=downloadFile&fn=ovpncnf
#
# Usage: ./vpn-upatras.sh [path/to/config.ovpn]   (default: newest *.ovpn in ~/Downloads)
set -Eeuo pipefail

FULL="UPatras VPN"

ovpn="${1:-$(command ls -t ~/Downloads/*.ovpn 2>/dev/null | head -1 || true)}"
if [[ -z "$ovpn" || ! -f "$ovpn" ]]; then
  echo "No .ovpn file found. Download it from:"
  echo "  https://mussa.upnet.gr/user/index.php?action=downloadFile&fn=ovpncnf"
  echo "then run: $0 path/to/config.ovpn"
  exit 1
fi
echo "==> Using $ovpn"

if ! dpkg -s network-manager-openvpn >/dev/null 2>&1; then
  sudo apt install -y network-manager-openvpn
fi

user=""
while [[ -z "$user" ]]; do
  read -rp "UPnet ID: " user
done

# Re-running replaces the profile
if nmcli -t -f NAME con show | grep -qxF "$FULL"; then
  nmcli con delete "$FULL" >/dev/null
fi

# Import copies the embedded certs to ~/.cert/nm-openvpn/
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
cp "$ovpn" "$tmp/$FULL.ovpn"
nmcli con import type openvpn file "$tmp/$FULL.ovpn" >/dev/null
# The uni's certificates are SHA-1 signed, which OpenSSL 3 rejects ("ca md too weak").
# SECLEVEL=0 only affects this VPN; drop it once upnet reissues them with SHA-256.
nmcli con modify "$FULL" connection.autoconnect no \
  +vpn.data "username=$user" +vpn.data "tls-cipher=DEFAULT:@SECLEVEL=0"

echo "==> Done. Connect with: nmcli con up \"$FULL\" --ask   (or from the network menu)"
