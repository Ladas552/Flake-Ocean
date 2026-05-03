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
          config.flake.modules.homeManager.wpaperd
          "${modulesPath}/programs/swaylock.nix"
          "${modulesPath}/services/mako.nix"
          "${modulesPath}/services/polkit-gnome.nix"
        ];
        services.mako = {
          enable = true;
          settings = {
            layer = "overlay";
            default-timeout = 5000;
            height = 1000;
          };
        };
        services.polkit-gnome.enable = true;
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
        ];
        niri.settings = {
          spawn-at-startup = [
            [
              "xfce4-power-manager"
              "--daemon"
            ]
            [ "wpaperd" ]
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
      };
  };
}
