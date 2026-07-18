{ config, ... }:
let
  custom.meta = {
    hostname = "NixIso";
    self = "~/Flake-Ocean";
    norg = null;
  };
in
{
  flake.modules.nixos."hosts/NixIso".imports =
    with config.flake.modules.nixos;
    [
      { inherit custom; }
      NixIso
      # Modules
      openssh
      bluetooth
      tlp
      cat-mocha
      sops
      fish
      nix
      xkb
      general
      niri-noct
      firefox
      thunar
      # Users
      root
      ladas552
    ]
    ++ [
      {
        hjem.users."${config.custom.meta.user}".imports = with config.flake.modules.hjem; [
          { inherit custom; }
          direnv
          git
          nvf
          vesktop
          mpv
          kitty
          cat-mocha
          imv
          chawan
          mpv
          # flameshot
          fastfetch
          niri-noct
        ];
      }
    ];
}
