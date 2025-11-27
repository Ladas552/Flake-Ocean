{
  flake.modules = {
    nixos.noct =
      {
        pkgs,
        inputs,
        lib,
        ...
      }:
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
    homeManager.noct =
      { config, inputs, ... }:
      {
        imports = [
          inputs.noctalia.homeModules.default
        ];
        programs.noctalia-shell = {
          enable = true;
          package = null;
          settings = ./settings.json;
          colors = ./colors.json;
        };
        programs.niri.settings = {
          layer-rules = [
            {
              matches = [ { namespace = "^noctalia-overview*"; } ];
              place-within-backdrop = true;
            }
          ];
          binds = with config.lib.niri.actions; {
            "Super+Space".action = spawn [
              "noctalia-shell"
              "ipc"
              "call"
              "launcher"
              "toggle"
            ];
            "Super+X".action = spawn [
              "noctalia-shell"
              "ipc"
              "call"
              "sessionMenu"
              "toggle"
            ];
            "Super+L".action = spawn [
              "noctalia-shell"
              "ipc"
              "call"
              "lockScreen"
              "lock"
            ];
            "Super+G".action = spawn [
              "noctalia-shell"
              "ipc"
              "call"
              "launcher"
              "calculator"
            ];
            "Super+D".action = spawn [
              "noctalia-shell"
              "ipc"
              "call"
              "bar"
              "toggle"
            ];
          };
        };
        # persist for Impermanence
        custom.imp.home.cache.directories = [ ".cache/noctalia/" ];
      };
  };
}
