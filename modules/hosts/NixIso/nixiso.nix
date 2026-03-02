{ self, config, ... }:
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
        # base for iso
        (modulesPath + "/installer/cd-dvd/installation-cd-base.nix")
      ];
      # Standalone Packages
      environment.systemPackages = with pkgs; [
        ungoogled-chromium
        wl-clipboard
        libqalculate
        wget
        lshw
        telegram-desktop
        xarchiver
        gparted
        restore
        # Get list of locales
        glibcLocales
      ];

      # Environmental Variables
      environment.variables = {
        BROWSER = "ungoogled-chromium";
      };

      nixpkgs.hostPlatform = "x86_64-linux";
      # SSH into an iso
      services.openssh.settings = {
        PermitRootLogin = lib.mkForce "yes";
        PasswordAuthentication = lib.mkForce true;
      };

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

      services.getty.autologinUser = lib.mkForce "${config.custom.meta.user}";
      users.users."${config.custom.meta.user}".hashedPasswordFile = lib.mkForce null;

      system.stateVersion = "26.05"; # Did you read the comment?
    };
}
