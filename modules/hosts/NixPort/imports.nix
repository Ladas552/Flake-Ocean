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
      # steam
      bluetooth
      cache
      cat-mocha
      cups
      firewall
      general
      imp
      # kdeconnect
      nh
      niri-flake
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
      tlp
      # lact
      noct
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
    # Specific Home-Manager modules
    ++ [
      {
        home-manager.users."${config.custom.meta.user}".imports = with config.flake.modules.homeManager; [
          { inherit custom; }
          NixPort
          cat-mocha
          lf
          lf-kitty
          manual
          vesktop
          zathura
        ];
      }
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
          niri-flake
          niri-nvim-colors
          noct
          bluetooth
          mpd
          syncthing
          fastfetch
        ];
      }
    ];
}
