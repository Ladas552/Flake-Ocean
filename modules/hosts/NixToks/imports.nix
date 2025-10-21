{ config, ... }:
{
  flake.modules.nixos."hosts/NixToks".imports =
    with config.flake.modules.nixos;
    [
      NixToks
      NixToks-hardware
      cat-mocha
      general
      grub
      imp-options
      nix
      sops
      tailscale
      zfs
      dashboard
      immich
      jellyfin
      karakeep
      kavita
      miniflux
      nextcloud
      qbittorrent
      cat-mocha
      distrobox
      fonts
      nh
      openssh
      pipewire
      plymouth
      qemu
      stylix
      tlp
      xkb
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
          direnv
          fastfetch
          fish
          gh
          git
          imp-options
          lf
          manual
          mpd
          openssh
          shell
          syncthing
          yt-dlp
        ];
      }
    ];
}
