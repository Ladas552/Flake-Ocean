{
  flake.modules.nixos.grub-legacy = {
    # GRUB Bootloader for legacy (no efi, msdos table) systems
    boot = {
      initrd.systemd.enable = true;
      loader.grub.enable = true;
      efiSupport = false;
      device = "/dev/sda";
      timeoutStyle = "hidden";
    };
  };
}
