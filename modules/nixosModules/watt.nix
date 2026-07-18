{
  flake.modules.nixos.watt = {
    powerManagement.enable = true;
    services.watt = {
      enable = true;
      settings = {
      };
    };
  };
}
