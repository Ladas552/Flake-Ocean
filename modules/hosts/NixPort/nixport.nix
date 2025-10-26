{
  flake.modules.nixos.NixPort =
    { inputs, pkgs, ... }:
    {
      # Define your hostname.
      networking.hostName = "NixPort";
      imports = [
        inputs.nixos-hardware.nixosModules.common-cpu-amd-zenpower
      ];
      # ZFS needs it
      networking.hostId = "f6d40058";
      # Xanmod kernel
      boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod;
      # https://wiki.archlinux.org/title/Lenovo_ThinkPad_T14s_(AMD)_Gen_3#Display
      boot.kernelParams = [ "amdgpu.dcdebugmask=0x10" ];
      # Enable networking
      networking.networkmanager.enable = true;
      # Radeon
      # Enable OpenGL and hardware accelerated graphics drivers
      services.xserver.videoDrivers = [ "modesetting" ];

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          vaapiVdpau
          vpl-gpu-rt
        ];
      };
      # Enable rocm
      nixpkgs.config.rocmSupport = true;
      hardware.amdgpu = {
        opencl.enable = true;
        initrd.enable = true;
      };
      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "24.11"; # Did you read the comment?
      # HJEM

      # persist my home on nixport to not interfere with server's /home
      custom.imp.home.directories = [
        "Share"
        "Pictures"
        "Projects"
        "Desktop"
        "Downloads"
        "Documents"
        "Videos"
        "Music"
        ".zotero"
        "Zotero"
      ];
    };
}
