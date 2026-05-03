{ config, self, ... }:
# my niri setup without a bar
{
  flake.modules = {
    nixos.niri-classic = {
      imports = [
        config.flake.modules.nixos.niri-flake
      ];
      # Enable Swaylock to unlock the screen
      security.pam.services.swaylock = { };
    };
    homeManager.niri-classic =
      { modulesPath, ... }:
      {
        imports = [
          config.flake.modules.homeManager.rofi
          "${modulesPath}/programs/swaylock.nix"
          "${modulesPath}/services/mako.nix"
        ];
        services.mako = {
          enable = true;
          settings = {
            layer = "overlay";
            default-timeout = 5000;
            height = 1000;
          };
        };
        programs.swaylock.enable = true;
      };
    hjem.niri-classic =
      { pkgs, ... }:
      {
        imports = [
          config.flake.modules.hjem.niri-flake
        ];
        packages = [
          self.packages.${pkgs.stdenv.hostPlatform.system}.rofi-powermenu
          pkgs.xfce4-power-manager
          pkgs.awww
        ];
        niri.settings = {
          spawn-at-startup = [
            [ "awww-daemon" ]
            [
              "xfce4-power-manager"
              "--daemon"
            ]
          ];
          binds = {
            "Super+L".spawn = "swaylock";
            "Super+Space".spawn = [
              "rofi"
              "-show"
            ];
            "Super+X".spawn = [ "powermenu.sh" ];
          };
        };
        systemd.services.awww-change-wallpaper =
          let
            script = ''
              while true; do
                IMG=$(find ~/Pictures/backgrounds -type f | shuf -n 1)
                [ -n "$IMG" ] && awww img -t any --transition-fps 90 "$IMG"
                sleep 10m
              done
            '';
          in
          {
            wantedBy = [ "graphical-session.target" ];
            description = "Change wallpaper every 10 minutes";
            after = [
              "graphical-session.target"
              "niri.service"
            ];
            path = [ pkgs.awww ];
            inherit script;
            serviceConfig = {
              Type = "simple";
              Restart = "on-failure";
              RestartSec = "5s";
            };
          };
      };
  };
}
