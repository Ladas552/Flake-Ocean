{ config, ... }:
let
  custom.meta = {
    hostname = "NixWool";
    self = "git+https://tangled.org/ladas552.me/flake-ocean";
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
      cache
      general
      imp
      nh
      nix
      openssh
      systemd-boot
      sops
      tailscale
      zfs
      network-manager
      fish
      bluesky-pds
      tangled
      run0
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
          fastfetch
          nvf
        ];
      }
    ];
}
