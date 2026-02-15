{ config, ... }:
let
  custom.meta = {
    hostname = "NixWool";
    self = "/persist/home/${config.custom.meta.user}/Projects/my_repos/Flake-Ocean";
    isTermux = false;
    norg = null;
  };
in
{
  flake.modules.nixvim.NixWool.imports = [ { inherit custom; } ];
  flake.modules.nvf.NixWool.imports = [ { inherit custom; } ];
  flake.modules.nixos."hosts/NixWool".imports =
    with config.flake.modules.nixos;
    [
      { inherit custom; }
      NixWool
      # Modules
      ## Games
      cache
      firewall
      general
      imp
      nh
      nix
      openssh
      sops
      tailscale
      zfs
      network-manager
      fish
      # Users
      root
      ladas552
    ]
    # Specific Home-Manager modules
    ++ [
      {
        home-manager.users."${config.custom.meta.user}".imports = with config.flake.modules.homeManager; [
          { inherit custom; }
          NixWool
          lf
        ];
      }
    ]

    ++ [
      {
        hjem.users."${config.custom.meta.user}".imports = with config.flake.modules.hjem; [
          { inherit custom; }
          direnv
          git
          nvf
          fastfetch
        ];
      }
    ];
}
