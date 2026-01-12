{
  flake.modules.nixos.ladas552 =
    { config, ... }:
    {
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
      nix.settings.trusted-users = [ "ladas552" ];
    };
}
