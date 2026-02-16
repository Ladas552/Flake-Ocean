# installation script for Hetzner VPS, I just loaded a standart nix iso in there
# Stolen from @Jet https://github.com/Michael-C-Buckley/nixos/blob/master/modules/hosts/o1/tools/format.sh
# Adapted to use msdos partition table

#!/usr/bin/env bash
set -euo pipefail

# ZFS Install Script for O1 (Oracle ARM instance)

ZFS_OPTS="-o ashift=12 \
  -O compression=zstd \
  -O atime=off \
  -O xattr=sa \
  -O acltype=posixacl \
  -O dnodesize=auto \
  -O normalization=formD \
  -O mountpoint=none"

hostname="NixWool"

read -rp "This will erase the drives, as you sure? [y/N]" confirm
if [[ $confirm =~ ^[Yy]$ ]]; then
  echo "Proceeding..."
else
  echo "Aborted."
  exit 1
fi

echo "Wiping drives..."
# Wipe the NVMe
wipefs -a /dev/sda

parted /dev/sda --script mklabel msdos

echo "Formatting drives..."
# Put boot on the NVMe then fill the rest with ZFS
parted /dev/sda --script mkpart primary 1MiB 4097MiB
parted /dev/sda --script mkpart primary 4097MiB 100%
parted /dev/sda --script set 2 boot on

# Swap
mkswap /dev/sda1
swapon /dev/sda1

# Create the pool on the drive, use reasonable settings
echo "Creating zroot..."
zpool create -f $ZFS_OPTS zroot /dev/sda2

# Mount the drives and prepare for the install
mkdir -p /mnt
mkdir -p /mnt/{cache,nix,persist,tmp,boot}

# This create the zvols used in this cluster
for zvol in "tmp" "nix" "cache" "persist"; do
  zfs create -o mountpoint=legacy zroot/$zvol
  mount -t zfs zroot/$zvol /mnt/$zvol
done

nixos-install --no-root-password --flake "github:Ladas552/Flake-Ocean#NixWool"

