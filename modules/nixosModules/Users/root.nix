{ config, ... }:
{
  flake.modules.nixos.root = args: {
    imports = [ config.flake.modules.nixos.users ];
    users.users.root = {
      initialPassword = "pass";
      hashedPasswordFile = args.config.sops.secrets."mystuff/host_pwd".path;
    };
  };
}
