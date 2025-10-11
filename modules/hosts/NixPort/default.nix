{
  config,
  ...
}:
{
  flake.modules.nixos."hosts/NixPort".imports =
    with config.flake.modules.nixos;
    [
      # Modules

      # Users
      root
      ladas552
    ]
    # Specific Home-Manager modules
    ++ [
      {
        home-manager.users.ladas552.imports = with config.flake.modules.HM; [
          chawan
          chromium
          direnv
          fastfetch
          fish
          gh
          ghostty
          helix
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
          zathura
        ];
      }
    ];
}
