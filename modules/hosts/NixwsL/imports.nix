{ config, ... }:
let
  custom.meta = {
    hostname = "NixwsL";
    self = "~/Flake-Ocean";
    isTermux = false;
    norg = "~/Documents/Norg";
  };
in
{
  flake.modules.nixos."hosts/NixwsL".imports =
    with config.flake.modules.nixos;
    [
      { inherit custom; }
      NixwsL
      fonts
      imp-options
      sops
      nix
      general
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
            NixwsL
            base
            git
            shell
            fish
            lf
            gh
            direnv
            fastfetch
            foot
            imp-options
          ];
      }
    ];
}
