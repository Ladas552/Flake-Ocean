{
  flake.modules.homeManager.wpaperd = args: {
    services.wpaperd = {
      enable = true;
      settings = {
        eDP-1 = {
          path = "${args.config.xdg.userDirs.pictures}/backgrounds";
          sorting = "random";
          duration = "10m";
        };
      };
    };
  };
}
