{ config, ... }:
let
  custom.meta = {
    hostname = "NixToks";
    self = "~/Flake-Ocean";
    isTermux = false;
    norg = "~/Documents/Norg";
  };
in
{
  flake.modules.nixos."hosts/NixToks".imports =
    with config.flake.modules.nixos;
    [
      { inherit custom; }
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
      ollama
      immich
      jellyfin
      karakeep
      kavita
      miniflux
      nextcloud
      qbittorrent
      distrobox
      nh
      openssh
      pipewire
      plymouth
      qemu
      tlp
      base
      xkb
      # Modules
      # Users
      root
      ladas552
    ]
    # Specific Home-Manager modules
    ++ [
      {
        home-manager.users."${config.custom.meta.user}".imports = with config.flake.modules.homeManager; [
          { inherit custom; }
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
