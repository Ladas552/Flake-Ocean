{ modules, ... }:
{
  flake.modules = {
    nixos.NixwsL =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        imports = [
          "${modules.nixos-wsl.src}/modules"
        ];

        # Standalone Packages
        environment.systemPackages = with pkgs; [
          libqalculate
          typst
        ];

        # Environmental Variables
        environment.variables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
          SUDO_EDITOR = "nvim";
        };

        # WSL isn't good with switch for some reason
        environment.shellAliases = { } // {
          yy = lib.mkForce "nh os boot ${config.custom.meta.self}";
          yyy = lib.mkForce "nh os boot -u ${config.custom.meta.self}";
        };

        wsl = {
          enable = true;
          defaultUser = "${config.custom.meta.user}";
          startMenuLaunchers = true;
          tarball.configPath = "${config.custom.meta.self}";
          usbip.enable = true;
          useWindowsDriver = true;
        };

        # This value determines the NixOS release from which the default
        # settings for stateful data, like file locations and database versions
        # on your system were taken. It‘s perfectly fine and recommended to leave
        # this value at the release version of the first install of this system.
        # Before changing this value read the documentation for this option
        # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
        system.stateVersion = "24.05"; # Did you read the comment?

        nixpkgs.hostPlatform = "x86_64-linux";
      };
    homeManager.NixwsL = {
      # Don't change
      home.stateVersion = "24.05"; # Please read the comment before changing.
    };
  };
}
