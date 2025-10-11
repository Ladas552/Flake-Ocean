{ config, ... }:
{
  flake = {
    meta.users.ladas552 = {
      name = "ladas552";
    };
    modules.users.ladas552 = {
      users.users.ladas552 = {
        isNormalUser = true;
        description = "Ladas552";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        initialPassword = "pass";
        hashedPasswordFile = config.sops.secrets."mystuff/host_pwd".path;
      };
      nix.settings.trusted-users = [ config.flake.meta.users.ladas552.name ];
    };
  };
}
