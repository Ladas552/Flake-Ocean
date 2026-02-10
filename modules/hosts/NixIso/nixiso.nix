{ self, ... }:
# build the image with
# nix run nixpkgs#nixos-generators -- --format iso --flake "github:Ladas552/Flake-Ocean#NixIso" -o result
{
  flake.modules.nixos.NixIso =
    {
      modulesPath,
      lib,
      pkgs,
      ...
    }:
    let
      restore = self.packages.${pkgs.stdenv.hostPlatform.system}.restore;
    in
    {
      imports = [
        # Include the results of the hardware scan.
        (modulesPath + "/installer/cd-dvd/installation-cd-graphical-calamares-gnome.nix")
      ];
      # Standalone Packages
      environment.systemPackages = with pkgs; [
        libreoffice-fresh
        # shotcut
        imagemagick
        wl-clipboard
        ffmpeg
        gst_all_1.gst-libav
        libqalculate
        lshw
        pamixer
        pwvucontrol
        qbittorrent
        telegram-desktop
        xarchiver
        gparted
        networkmanagerapplet
        restore
        # Get list of locales
        glibcLocales
      ];

      # Environmental Variables
      environment.variables = {
        BROWSER = "chromium";
      };

      services.greetd.enable = false;
      nixpkgs.hostPlatform = "x86_64-linux";
      services.openssh.settings.PermitRootLogin = lib.mkForce "yes";

      networking.hostName = "NixIso";
      # Xanmod kernel
      boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod;

      # Enable networking
      networking.networkmanager.enable = true;
      networking.wireless.enable = lib.mkForce false;

      # Seg faults the iso build
      # i18n.supportedLocales = lib.mkForce [ "all" ];

      # graphics
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      # specialisation.AMD-GPU.configuration = {
      #   # Radeon
      #   # Enable OpenGL and hardware accelerated graphics drivers
      #   services.xserver.videoDrivers = [ "modesetting" ];

      #   hardware.amdgpu = {
      #     opencl.enable = true;
      #     initrd.enable = true;
      #   };
      #   # https://wiki.archlinux.org/title/Lenovo_ThinkPad_T14s_(AMD)_Gen_3#Display
      #   boot.kernelParams = [ "amdgpu.dcdebugmask=0x10" ];
      # };

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "25.11"; # Did you read the comment?
    };
}
