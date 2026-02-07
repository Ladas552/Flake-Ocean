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
        openssh.authorizedKeys.keys = [
          "ssh-ed25520 AAAAC3NzaC1lZDI1NTE5AAAAIPiFWLpIrKZ1+8PPSegYpNrRaPlE4t7iVUnHucvWQJJx ladas552@NixPort"
        ];
      };
      nix.settings.trusted-users = [ "ladas552" ];
    };
}
