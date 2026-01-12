{ inputs, ... }:
{
  flake.modules = {
    nixos.noct =
      { pkgs, lib, ... }:
      {
        environment.systemPackages = with pkgs; [
          inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
          (python3.withPackages (pyPkgs: with pyPkgs; [ pygobject3 ]))
        ];
        # import the nixos module
        imports = [
          inputs.noctalia.nixosModules.default
        ];
        # enable the systemd service
        services.noctalia-shell.enable = true;

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
        inputs.noctalia.homeModules.default
      ];
      programs.noctalia-shell = {
        enable = true;
        package = null;
        settings = ./settings.json;
        colors = ./colors.json;
      };
      # persist for Impermanence
      custom.imp.home.cache.directories = [ ".cache/noctalia/" ];
    };
    hjem.noct = {
      xdg.config.files = {
        "noctalia/settings.json".source = ./settings.json;
        "noctalia/colors.json".source = ./colors.json;
      };
      # persist for Impermanence
      custom.imp.home.cache.directories = [ ".cache/noctalia/" ];
    };
  };
}
