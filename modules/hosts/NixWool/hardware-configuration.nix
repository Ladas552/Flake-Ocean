{
  flake.modules.nixos.NixWool =
    {
      lib,
      modulesPath,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
        (modulesPath + "/profiles/qemu-guest.nix")
      ];

      boot.initrd.availableKernelModules = [
        "ahci"
        "virtio_pci"
        "sd_mod"
        "sr_mod"
        "xhci_pci"
        "virtio_scsi"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-amd" ];
      boot.extraModulePackages = [ ];

      swapDevices = [ ];

      # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
      # (the default) this is the recommended approach. When using systemd-networkd it's
      # still possible to use this option, but it's recommended to use it in conjunction
      # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
      networking.useDHCP = lib.mkDefault true;
      # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

      nixpkgs.hostPlatform = "aarch64-linux";
      hardware.cpu.amd.updateMicrocode = true;
    };
}
