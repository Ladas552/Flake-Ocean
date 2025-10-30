{
  flake.modules.hjem.flameshot = {
    rum.programs.flameshot = {
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
