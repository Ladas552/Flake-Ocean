{ inputs, self, ... }:
# build the image with
# nix run nixpkgs#nixos-generators -- --format iso --flake "github:Ladas552/Nix-Is-Unbreakable#NixIso" -o result
{
  flake.modules.nixos.NixIso =
    {
      modulesPath,
      lib,
      pkgs,
      ...
    }:
    let
      restore = self.packages.${pkgs.system}.restore;
    in
    {
      imports = [
        # Include the results of the hardware scan.
        (modulesPath + "/installer/cd-dvd/installation-cd-graphical-calamares-gnome.nix")
      ];
      services.greetd.enable = false;
      nixpkgs.hostPlatform = "x86_64-linux";
      services.openssh.settings.PermitRootLogin = lib.mkForce "yes";

      home-manager = {
        extraSpecialArgs = {
          inherit inputs;
        };
        useUserPackages = true;
        useGlobalPkgs = true;
      };
      # Xanmod kernel
      boot.kernelPackages = pkgs.linuxKernel.packages.linux_xanmod;

      # Enable networking
      networking.networkmanager.enable = true;
      networking.wireless.enable = lib.mkForce false;

      environment.systemPackages = with pkgs; [
        gparted
        networkmanagerapplet
        restore
        # Get list of locales
        glibcLocales
      ];
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
      system.stateVersion = "25.05"; # Did you read the comment?
    };
}
