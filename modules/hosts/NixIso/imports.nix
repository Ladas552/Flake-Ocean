{ config, lib, ... }:
let
  custom.meta = {
    # force to change the user because it suppose to be inherited from topLevel
    user = lib.mkForce "nixos";
    hostname = "NixIso";
    self = "~/Flake-Ocean";
    isTermux = false;
    norg = "~/Documents/Norg";
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
      xkb
      sops
      fish
      nix
      # Users
      root
      # I don't know why, but it creates ladas552 user in my config somewhere, but I use `nixos` user in NixIso
      # So it needs at least a viable ladas552 normal user, otherwise it won't compile.
      # I am loosing my mind
      ladas552
    ]
    # Specific Home-Manager modules
    ++ [
      {
        home-manager.users."nixos".imports = with config.flake.modules.homeManager; [
          { inherit custom; }
          NixIso
          vim
          gh
          lf
          mpv
          vesktop
          thunderbird
          zathura
          manual
          cat-mocha
          git
        ];
      }
    ]
    ++ [
      {
        hjem.users."nixos".imports = with config.flake.modules.hjem; [
          { inherit custom; }
          direnv
          obs
          # git
          helix
          ghostty
          cat-mocha
          imv
          chawan
          mpv
          helium
          # flameshot
          bluetooth
          mpd
          syncthing
          fastfetch
        ];
      }
    ];
}
