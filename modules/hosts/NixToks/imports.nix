{ config, ... }:
{
  flake.modules.nixos."hosts/NixToks".imports =
    with config.flake.modules.nixos;
    [
      NixToks
      NixToks-hardware
      cat-mocha
      imp-options
      tailscale
      sops
      stylix
      zfs
      grub
      nix
      general
      # Modules
      # Users
      users
      root
      ladas552
    ]
    # Specific Home-Manager modules
    ++ [
      {
        home-manager.users.ladas552.imports = with config.flake.modules.homeManager; [
          NixToks
          base
          cat-mocha
          shell
          fish
          syncthing
          mpd
          lf
          gh
          fastfetch
          direnv
          imp-options
          git
          manual
        ];
      }
    ];
}
