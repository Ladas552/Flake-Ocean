{
  flakes.modules.HM.flameshot = {
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
