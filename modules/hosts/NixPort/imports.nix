{ config, ... }:
{
  flake.modules.nixos."hosts/NixPort".imports =
    with config.flake.modules.nixos;
    [
      NixPort
      NixPort-hardware
      # Modules
      ## Games
      games
      emulators
      bluetooth
      cache
      catppuccin-mocha
      cups
      firewall
      fonts
      general
      greetd
      imp
      kdeconnect
      nh
      niri
      nix
      openssh
      otd
      pipewire
      plymouth
      sops
      stylix
      systemd-boot
      tailscale
      thunar
      tlp
      xkb
      zfs
      # Users
      users
      root
      ladas552
    ]
    # Specific Home-Manager modules
    ++ [
      {
        home-manager.users.ladas552.imports = with config.flake.modules.homeManager; [
          NixPort
          catppuccin-mocha
          chawan
          chromium
          direnv
          fastfetch
          fish
          gh
          ghostty
          git
          imp
          imv
          lf
          mako
          manual
          mpd
          mpv
          niri
          obs
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
        ];
      }
    ];
}
