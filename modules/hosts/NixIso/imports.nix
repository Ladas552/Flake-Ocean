{ config, ... }:
let
  custom.meta = {
    hostname = "NixIso";
    self = "~/Flake-Ocean";
    isTermux = false;
    norg = "~/Documents/Norg";
  };
in
{
  flake.modules.nixos."hosts/NixIso".imports =
    with config.flake.modules.nixos;
    [
      { inherit custom; }
      NixIso
      # Modules
      ## Games
      openssh
      bluetooth
      tlp
      cat-mocha
      xkb
      imp-options
      sops
      base
      # Users
      root
      ladas552
    ]
    # Specific Home-Manager modules
    ++ [
      {
        home-manager.users."${config.custom.meta.username}".imports =
          with config.flake.modules.homeManager; [
            { inherit custom; }
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
