{
  flake.modules.nixos.tlp = {
    powerManagement.enable = true;
    services.tlp.enable = true;
    services.power-profiles-daemon.enable = false;
    services.upower.enable = true;
  };
}
