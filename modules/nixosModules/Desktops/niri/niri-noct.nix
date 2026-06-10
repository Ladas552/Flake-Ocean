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
          [ "noctalia" ]
        ];
        # overview wallpaper
        layer-rule = [
          {
            # Noctalia wallpaper in overview
            _children = [ { match._props.namespace = "^noctalia-backdrop"; } ];
            place-within-backdrop = true;
          }
        ];
        # noctalia tools
        binds = {
          # Noctalia
          "Super+Space".spawn = [
            "noctalia"
            "msg"
            "panel-toggle"
            "launcher"
          ];
          "Super+X".spawn = [
            "noctalia"
            "msg"
            "panel-toggle"
            "session"
          ];
          "Super+D".spawn = [
            "noctalia"
            "msg"
            "bar-toggle"
          ];
        };
      };
    };
  };
}
