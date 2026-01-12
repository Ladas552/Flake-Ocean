{
  flake.modules.nixos.root =
    { config, ... }:
    {
      users.users.root = {
        initialPassword = "pass";
        hashedPasswordFile = config.sops.secrets."mystuff/host_pwd".path;
      };
    };
}
