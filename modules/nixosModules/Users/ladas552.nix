{
  flake.modules.nixos.ladas552 = args: {
    users.users.ladas552 = {
      isNormalUser = true;
      description = "Ladas552";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      initialPassword = "pass";
      hashedPasswordFile = args.config.sops.secrets."mystuff/host_pwd".path;
    };
    nix.settings.trusted-users = [ "ladas552" ];
  };
}
