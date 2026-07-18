{ config, ... }:
let
  custom.meta = {
    hostname = "NixPort";
    self = "/persist/home/${config.custom.meta.user}/Projects/my_repos/Flake-Ocean";
    norg = "~/Documents/Norg";
  };
in
{
  flake.modules.nvf.NixPort.imports = [ { inherit custom; } ];
  flake.modules.nixos."hosts/NixPort".imports =
    with config.flake.modules.nixos;
    [
      { inherit custom; }
      NixPort
      # Modules
      ## Games
      games
      # emulators
      steam
      bluetooth
      cache
      keyd-canary
      cat-mocha
      printer
      firewall
      general
      imp
      # kdeconnect
      nh
      nuphy
      nix
      openssh
      otd
      pipewire
      plymouth
      sops
      adb
      systemd-boot
      tailscale
      thunar
      watt
      # tlp
      # lact
      # niri-classic
      niri-noct
      nixos-core-testing
      xkb
      zfs
      run0
      network-manager
      fish
      yt-dlp
      firefox
      thunderbird
      # Users
      root
      ladas552
    ]
    ++ [
      {
        hjem.users."${config.custom.meta.user}".imports = with config.flake.modules.hjem; [
          { inherit custom; }
          openssh
          direnv
          obs
          git
          neovide
          kitty
          cat-mocha
          imv
          chawan
          nvf
          mpv
          # flameshot
          # helium
          # niri-classic
          niri-noct
          niri-nvim-colors
          bluetooth
          mpd
          vesktop
          syncthing
          fastfetch
        ];
      }
    ];
}
