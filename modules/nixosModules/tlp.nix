{
  flake.modules.nixos.tlp = {
    powerManagement.enable = true;
    services.tlp = {
      pd.enable = true;
      enable = true;
    };
    services.power-profiles-daemon.enable = false;
    services.upower.enable = true;
    services.thermald.enable = true;
  };
}
