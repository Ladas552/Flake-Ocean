{
  # I have this nasty bug that corrupts my /boot, I need to fix it
  # but here is a script I use to not do it manually everytime
  # Do this all in sudo tho

  perSystem =
    { pkgs, ... }:
    {
      packages.restore =
        pkgs.writeShellScriptBin "restore.sh" # bash
          ''
            mkfs.vfat /dev/nvme0n1p5 -n NIXBOOT
            zpool import zroot -f
            # Need so that install doesn't run out of memory
            zfs create -o mountpoint=legacy zroot/root
            mount -t zfs zroot/root /mnt
            mount --mkdir /dev/nvme0n1p5 /mnt/boot
            mount --mkdir -t zfs zroot/nix /mnt/nix
            mount --mkdir -t zfs zroot/tmp /mnt/tmp
            mount --mkdir -t zfs zroot/cache /mnt/cache
            mount --mkdir -t zfs zroot/persist /mnt/persist
            nixos-install --no-root-password --flake "github:Ladas552/Flake-Ocean#NixPort"
            # unmount the system, and remount it to correctly link the build
            umount /mnt/boot
            umount /mnt/nix
            umount /mnt/cache
            umount /mnt/tmp
            umount /mnt/persist
            umount /mnt
            mount --mkdir /dev/nvme0n1p5 /mnt/boot
            mount --mkdir -t zfs zroot/nix /mnt/nix
            mount --mkdir -t zfs zroot/tmp /mnt/tmp
            mount --mkdir -t zfs zroot/cache /mnt/cache
            mount --mkdir -t zfs zroot/persist /mnt/persist
            nixos-install --no-root-password --flake "github:Ladas552/Flake-Ocean#NixPort"
          '';
    };
}
