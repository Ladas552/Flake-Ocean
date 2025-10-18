{ config, ... }:
{
  flake.modules.nixos."hosts/NixIso".imports =
    with config.flake.modules.nixos;
    [
      NixIso
      # Modules
      ## Games
      openssh
      bluetooth
      fonts
      tlp
      stylix
      cat-mocha
      xkb
      imp-options
      sops
      # Users
      users
      root
      ladas552
    ]
    # Specific Home-Manager modules
    ++ [
      {
        home-manager.users.ladas552.imports = with config.flake.modules.homeManager; [
          NixIso
          base
          vim
          chromium
          direnv
          fastfetch
          gh
          ghostty
          helix
          imv
          lf
          mpv
          obs
          vesktop
          rofi
          thunderbird
          zathura
          shell
          fish
          imp-options
          manual
          shell
          cat-mocha
          git
        ];
      }
    ];
}
