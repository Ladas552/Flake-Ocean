{ config, ... }:
let
  custom.meta = {
    hostname = "NixPort";
    self = "/persist/home/ladas552/Projects/my_repos/Flake-Ocean";
    isTermux = false;
    norg = "~/Documents/Norg";
  };
in
{
  flake.modules.nixos."hosts/NixPort".imports =
    with config.flake.modules.nixos;
    [
      { inherit custom; }
      NixPort
      # Modules
      ## Games
      games
      emulators
      bluetooth
      cache
      cat-mocha
      cups
      firewall
      general
      imp
      imp-options
      kdeconnect
      nh
      niri
      nix
      openssh
      otd
      pipewire
      plymouth
      sops
      systemd-boot
      tailscale
      thunar
      tlp
      xkb
      zfs
      base
      network-manager
      # Users
      root
      ladas552
    ]
    # Specific Home-Manager modules
    ++ [
      {
        home-manager.users."${config.custom.meta.user}".imports = with config.flake.modules.homeManager; [
          { inherit custom; }
          NixPort
          base
          cat-mocha
          chawan
          chromium
          direnv
          fastfetch
          fish
          gh
          ghostty
          imp-options
          imv
          lf
          mako
          manual
          mpd
          mpv
          niri
          rofi
          shell
          swaylock
          syncthing
          thunderbird
          vesktop
          wpaperd
          yt-dlp
          zathura
          zfs
          openssh
        ];
      }
    ]
    ++ [
      {
        hjem.users."${config.custom.meta.user}".imports = with config.flake.modules.hjem; [
          { inherit custom; }
          # fish
          # direnv
          obs
          git
          neovide
        ];
      }
    ];
}
