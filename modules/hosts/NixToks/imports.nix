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
  flake.modules.nvf.NixToks.imports = [ { inherit custom; } ];
  flake.modules.nixos."hosts/NixToks".imports =
    with config.flake.modules.nixos;
    [
      { inherit custom; }
      NixToks
      cat-mocha
      general
      cache
      grub-efi
      nix
      sops
      tailscale
      zfs
      dashboard
      # ollama
      # open-webui
      searxng
      # immich
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
      fish
      yt-dlp-NixToks

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
          gh
          git
          lf
          manual
          openssh
        ];
      }
    ]
    ++ [
      {
        hjem.users."${config.custom.meta.user}".imports = with config.flake.modules.hjem; [
          { inherit custom; }
          nvf
          mpd
          syncthing
          helix
          direnv
          fastfetch
          cat-mocha
        ];
      }
    ];
}
