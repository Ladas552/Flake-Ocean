{ modules, ... }:
{
  flake.modules = {
    nixos.noct =
      { pkgs, lib, ... }:
      let
        noct = pkgs.callPackage "${modules.noctalia-dev.src}/nix/package.nix" {
          calendarSupport = true;
        };
      in
      {
        environment.systemPackages = with pkgs; [
          noct
          gpu-screen-recorder
        ];
        # import the nixos module
        imports = [
          "${modules.noctalia-dev.src}/nix/nixos-module.nix"
        ];
        # enable the systemd service
        services.noctalia-shell = {
          enable = true;
          package = noct;
        };

        # make calendar events work
        services.gnome.evolution-data-server.enable = true;
        environment.sessionVariables = {
          GI_TYPELIB_PATH = lib.makeSearchPath "lib/girepository-1.0" (
            with pkgs;
            [
              evolution-data-server
              libical
              glib.out
              libsoup_3
              json-glib
              gobject-introspection
            ]
          );
        };
      };
    homeManager.noct = {
      imports = [
        "${modules.noctalia-dev.src}/nix/home-module.nix"
      ];
      programs.noctalia-shell = {
        enable = true;
        package = null;
        settings = ./settings.json;
        colors = ./colors.json;
        plugins = ./plugins.json;
        pluginSettings.screen-recorder = ./noct/recorder-settings.json;
      };
      # persist for Impermanence
      custom.imp.home.cache.directories = [
        ".cache/noctalia"
        ".config/noctalia/plugins"
      ];
    };
    hjem.noct = {
      xdg.config.files = {
        "noctalia/settings.json".source = ./noct/settings.json;
        "noctalia/colors.json".source = ./noct/colors.json;
        "noctalia/plugins.json".source = ./noct/plugins.json;
        "noctalia/plugins/screen-recorder/settings.json".source = ./noct/recorder-settings.json;
      };
      # persist for Impermanence
      custom.imp.home.cache.directories = [
        ".cache/noctalia"
        ".config/noctalia/plugins"
      ];
    };
  };
}
