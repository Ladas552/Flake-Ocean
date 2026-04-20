{ inputs, ... }:
{
  flake.modules = {
    nixos.niri-flake =
      { pkgs, config, ... }:
      {
        imports = [
          inputs.niri.nixosModules.default
        ];

        # To use master branch niri without building rust
        nix.settings = {
          extra-substituters = [
            "https://niri-nix.cachix.org"
          ];
          extra-trusted-public-keys = [
            "niri-nix.cachix.org-1:SvFtqpDcf7Sm1SMJdby1/+Y+6f3Yt3/3PMcSTKPJNJ0="
          ];
        };
        nixpkgs.overlays = [ inputs.niri.overlays.niri-nix ];
        # Niri using flake
        # uncomment the niri inputs in flake.nix to use this
        programs.niri = {
          enable = true;
          useNautilus = false;
          package = pkgs.niri-unstable;
          # I use my own portal settings
          withXDG = false;
        };

        environment.systemPackages = with pkgs; [
          inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.xwayland-satellite-unstable
          brightnessctl
          # xfce4-power-manager
          # self.packages.${pkgs.stdenv.hostPlatform.system}.rofi-powermenu
          # self.packages.${pkgs.stdenv.hostPlatform.system}.wpick
        ];

        environment.variables = {
          DISPLAY = ":0";

          NIXOS_OZONE_WL = "1";

          ELECTRON_LAUNCH_FLAGS = "--enable-wayland-ime --wayland-text-input-version=3 --enable-features=WaylandLinuxDrmSyncobj";
        };

        xdg.portal = {
          enable = true;
          xdgOpenUsePortal = true;
          extraPortals = [
            pkgs.xdg-desktop-portal-gnome
            pkgs.xdg-desktop-portal-gtk
          ];
          config = {
            niri."org.freedesktop.impl.portal.FileChooser" = "gtk";
            niri.default = "gnome";
            common.default = "gnome";
            obs.default = "gnome";
          };
        };

        # Autologin
        services.displayManager.autoLogin.enable = true;
        services.displayManager.autoLogin.user = "${config.custom.meta.user}";
        services.greetd = {
          enable = true;
          settings = rec {
            # initial session for autologin
            # https://wiki.archlinux.org/title/Greetd#Enabling_autologin
            initial_session = {
              command = "niri-session";
              user = "${config.custom.meta.user}";
            };
            default_session = initial_session;
          };
        };
      };

    hjem.niri-flake =
      { lib, config, ... }:
      # create options to merge niri config from different modules
      {
        options.niri = {
          settings = lib.mkOption {
            type =
              with lib.types;
              let
                valueType =
                  nullOr (oneOf [
                    bool
                    int
                    float
                    str
                    path
                    (attrsOf valueType)
                    (listOf valueType)
                  ])
                  // {
                    description = "Niri configuration value";
                  };
              in
              types.submodule {
                freeformType = valueType;
              };
            default = { };
            description = ''
              KDL configuration for Niri written in Nix.
            '';
          };
          extraConfig = lib.mkOption {
            type = lib.types.lines;
            default = "";
            description = ''
              Extra configuration lines to be added verbatim.
            '';
          };

          finalConfig = lib.mkOption {
            type = lib.types.lines;
            default = (inputs.niri.lib.mkNiriKDL config.niri.settings) + "\n" + config.niri.extraConfig;
            description = ''
              The final config applied to niri.
            '';
          };

        };
        config = {
          niri.settings = import ./_niri-config.nix { };
          xdg.config.files."niri/config.kdl".text = config.niri.finalConfig;
        };
      };
  };
}
