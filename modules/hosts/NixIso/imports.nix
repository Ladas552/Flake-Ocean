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
          chromium
          direnv
          fastfetch
          gh
          ghostty
          helix
          imv
          lf
          mpv
          obs
          vesktop
          rofi
          thunderbird
          zathura
          shell
          fish
          manual
          shell
          cat-mocha
          git
        ];
      }
    ];
}
