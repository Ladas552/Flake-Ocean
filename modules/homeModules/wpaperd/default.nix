{ config, ... }:
{
  flake.modules.HM.wpaperd = {
    services.wpaperd = {
      enable = true;
      settings = {
        eDP-1 = {
          path = "${config.xdg.userDirs.pictures}/backgrounds";
          sorting = "random";
          duration = "10m";
        };
      };
    };
  };
}
