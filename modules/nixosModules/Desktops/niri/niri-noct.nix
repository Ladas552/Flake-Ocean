{ config, ... }:
{
  flake.modules = {
    nixos.niri-noct = {
      imports = [
        config.flake.modules.nixos.noct
        config.flake.modules.nixos.niri-flake
      ];
    };
    hjem.niri-noct = {
      imports = [
        config.flake.modules.hjem.noct
        config.flake.modules.hjem.niri-flake
      ];
      niri.settings = {
        # autostart noctalia-shell
        spawn-at-startup = [
          [ "noctalia-shell" ]
        ];
        # overview wallpaper
        layer-rule = [
          {
            # Noctalia wallpaper in overview
            _children = [ { match._props.namespace = "^noctalia-overview*"; } ];
            place-within-backdrop = true;
          }
        ];
        # noctalia tools
        binds = {
          # Noctalia
          "Super+Space".spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "launcher"
            "toggle"
          ];
          "Super+X".spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "sessionMenu"
            "toggle"
          ];
          "Super+L".spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "lockScreen"
            "lock"
          ];
          "Super+D".spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "bar"
            "toggle"
          ];
        };
      };
    };
  };
}
