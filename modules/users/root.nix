{ config, ... }:
{

  flake = {
    meta.users.root = {
      name = "root";
    };
    modules.users.root = {
      users.users.root = {
        initialPassword = "pass";
        hashedPasswordFile = config.sops.secrets."mystuff/host_pwd".path;
      };
    };
  };
}
