{ config, ... }:
let
  custom.meta = {
    hostname = "NixToks";
    self = "/home/${config.custom.meta.user}/Flake-Ocean";
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
      cat-mocha
      general
      grub
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
          cat-mocha
          direnv
          fastfetch
          fish
          gh
          git
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
