{
  flake.modules.homeManager.flameshot = {
    services.flameshot = {
      enable = true;
      settings = {
        General = {
          showHelp = false;
          showDesktopNotification = false;
        };
      };
    };
  };
}
