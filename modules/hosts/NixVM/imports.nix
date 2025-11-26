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
      cat-mocha
      nix
      general
      # Users
      root
      ladas552
    ]
    # Specific Home-Manager modules
    ++ [
      {
        home-manager.users."${config.custom.meta.user}".imports = with config.flake.modules.homeManager; [
          { inherit custom; }
          NixVm
          ghostty
          direnv
          cat-mocha
          imv
          shell
          git
          fish
        ];
      }
    ];
}
