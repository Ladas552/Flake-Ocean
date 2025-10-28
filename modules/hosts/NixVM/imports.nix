{ config, ... }:
let
  custom.meta = {
    hostname = "NixVm";
    self = "~/Flake-Ocean";
    isTermux = false;
    norg = "~/Documents/Norg";
  };
in
{
  flake.modules.nixos."hosts/NixVm".imports =
    with config.flake.modules.nixos;
    [
      { inherit custom; }
      NixVm
      NixVm-hardware
      # Modules
      niri
      openssh
      fonts
      sops
      zerotier
      systemd-boot
      imp-options
      base
      nix
      general
      # Users
      root
      ladas552
    ]
    # Specific Home-Manager modules
    ++ [
      {
        home-manager.users."${config.custom.meta.username}".imports =
          with config.flake.modules.homeManager; [
            { inherit custom; }
            NixVm
            base
            ghostty
            direnv
            imv
            shell
            git
            fish
            imp-options
          ];
      }
    ];
}
