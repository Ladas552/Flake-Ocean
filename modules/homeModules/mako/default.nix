{
  flake.modules.HM.mako = {
    services.mako = {
      enable = true;
      settings = {
        layer = "overlay";
        default-timeout = 5000;
        height = 1000;
      };
    };
  };
}
