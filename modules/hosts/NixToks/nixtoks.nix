{
  flake.modules.nixos.NixToks =
    {
      inputs,
      config,
      pkgs,
      ...
    }:
    {

      sops.age.keyFile = "/home/ladas552/.config/sops/age/keys.txt";
      sops.age.sshKeyPaths = [
        "/home/ladas552/.ssh/NixToks"
      ];

      # Define your hostname.
      networking.hostName = "NixToks";
      imports = [
        # enable trimming
        inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
      ];
      # Needed for ZFS, generated from command:
      # head -c 8 /etc/machine-id
      networking.hostId = "98d7caca";

      #build machine for termux
      # Termux builder
      boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

      # Xanmod kernel
      boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod;

      # Linux sheduler, works post 6.12
      # services.scx = {
      #   enable = true;
      #   package = pkgs.scx.rustscheds;
      # };

      # Networking
      # NixToks wifi card is dead
      networking.networkmanager.enable = false;

      # Nvidia
      # Enable OpenGL and hardware accelerated graphics drivers

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          vaapiVdpau
          intel-media-driver
          intel-ocl
          vpl-gpu-rt
        ];
      };

      # Load nvidia driver for Xorg and Wayland
      services.xserver.videoDrivers = [ "nvidia" ]; # or "nvidiaLegacy470 etc.
      hardware.nvidia = {
        modesetting.enable = true;
        open = false;
        package = config.boot.kernelPackages.nvidiaPackages.beta;
        prime = {
          sync.enable = true;
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };
      # Enable cuda. Needs building
      nixpkgs.config.cudaSupport = true;
      # Environmental variable for Wayland and stuff
      environment.variables = {
        __NV_PRIME_RENDER_OFFLOAD = 1;
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        LIBVA_DRIVER_NAME = "nvidia";
        GBM_BACKEND = "nvidia-drm";
      };
      # IF statement to enable vitalization for Nvidia in Docker. If Docker module is disabled it returns false, if enabled returns true
      hardware.nvidia-container-toolkit.enable = config.virtualisation.podman.enable;

      # Define a user account. Check Impermanence Module for user password
      users.users."ladas552".extraGroups = [ "media" ];

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "25.11"; # Did you read the comment?

      ## Powermanagment
      ## It disabled usb after some time of incativity, so not usable on desktop

      powerManagement.powertop.enable = true;

      ## Turn off screen and don't go to sleep
      services.logind.settings.Login = {
        HandleLidSwitchExternalPower = "ignore";
        HandleLidSwitchDocked = "ignore";
        HandleLidSwitch = "ignore";
      };

      ## Stuff to make server operatable
      users.groups."media" = { };

      services.caddy = {
        enable = true;
      };

      # Open firewall ports
      networking.firewall.allowedTCPPorts = [
        80
        443
      ];

      ##### ZFS MOUNT POINTS
      ##### Because I have additional drive for NixToks
      fileSystems."/mnt/zmedia" = {
        device = "zmedia/files";
        fsType = "zfs";
      };
      # media files for torrents and stuff on main drive
      fileSystems."/srv/media" = {
        device = "zroot/media";
        fsType = "zfs";
      };
    };

}
