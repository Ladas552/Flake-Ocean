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
      zfs
      grub
      nix
      general
      qbittorrent
      dashboard
      immich
      jellyfin
      kavita
      miniflux
      nextcloud
      karakeep
      xkb
      openssh
      fonts
      tlp
      distrobox
      qemu
      plymouth
      stylix
      cat-mocha
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
