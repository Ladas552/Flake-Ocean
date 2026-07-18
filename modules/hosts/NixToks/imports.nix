{ config, ... }:
let
  custom.meta = {
    hostname = "NixToks";
    self = "/home/${config.custom.meta.user}/Flake-Ocean";
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
      # grub-efi
      systemd-boot
      nix
      sops
      tailscale
      zfs
      dashboard
      # incus
      # ollama
      # open-webui
      # sunshine
      technitium
      searxng
      immich
      jellyfin
      karakeep
      kavita
      miniflux
      minecraft-server
      nextcloud
      # ncps
      nixos-core-testing
      qbittorrent
      copyparty
      gonic
      # distrobox
      nh
      openssh
      pipewire
      # plymouth
      # matrix-conduit
      # qemu
      tlp
      xkb
      fish
      yt-dlp-NixToks
      run0

      # temporary
      # tangled
      # Modules
      # Users
      root
      ladas552
    ]
    ++ [
      {
        hjem.users."${config.custom.meta.user}".imports = with config.flake.modules.hjem; [
          { inherit custom; }
          git
          nvf
          mpd
          syncthing
          helix
          direnv
          fastfetch
          cat-mocha
          openssh
        ];
      }
    ];
}
