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
      ## Games
      openssh
      bluetooth
      tlp
      cat-mocha
      sops
      fish
      nix
      general
      niri-flake
      noct
      # Users
      root
      ladas552
    ]
    # Specific Home-Manager modules
    ++ [
      {
        home-manager.users."${config.custom.meta.user}".imports = with config.flake.modules.homeManager; [
          { inherit custom; }
          NixIso
          gh
          lf
          vesktop
          zathura
          manual
          cat-mocha
          git
        ];
      }
    ]
    ++ [
      {
        hjem.users."${config.custom.meta.user}".imports = with config.flake.modules.hjem; [
          { inherit custom; }
          direnv
          obs
          # git
          helix
          mpv
          ghostty
          cat-mocha
          imv
          chawan
          mpv
          # flameshot
          fastfetch
          niri-flake
          noct
        ];
      }
    ];
}
