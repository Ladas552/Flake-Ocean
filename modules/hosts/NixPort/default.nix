{
  config,
  ...
}:
{
  flake.modules.nixos."hosts/NixPort".imports =
    with config.flake.modules.nixos;
    [
      NixPort
      # Modules
      cache
      firewall
      fonts
      base
      greetd
      nh
      nix
      openssh
      pipewire
      sops
      imp
      niri
      bluetooth
      kdeconnect
      games
      otd
      cups
      tlp
      plymouth
      stylix
      catppuccin-mocha
      systemd-boot
      xkb
      tailscale
      thunar
      zfs
      NixPort-hardware
      # Users
      users
      root
      ladas552
    ]
    # Specific Home-Manager modules
    ++ [
      {
        home-manager.users.ladas552.imports = with config.flake.modules.homeManager; [
          imp
          catppuccin-mocha
          NixPort
          chawan
          chromium
          direnv
          fastfetch
          fish
          git
          gh
          ghostty
          imv
          lf
          manual
          mpd
          mpv
          obs
          rofi
          shell
          syncthing
          thunderbird
          vesktop
          yt-dlp
          mako
          zathura
          swaylock
          wpaperd
        ];
      }
    ];
}
