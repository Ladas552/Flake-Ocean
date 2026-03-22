{ config, ... }:
let
  custom.meta = {
    hostname = "NixwsL";
    self = "/home/${config.custom.meta.user}/Flake-Ocean";
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
      sops
      nix
      general
      cat-mocha
      cache
      nh
      openssh
      run0
      fish
      # Users
      root
      ladas552
    ]
    # Specific Home-Manager modules
    ++ [
      {
        home-manager.users."${config.custom.meta.user}".imports = with config.flake.modules.homeManager; [
          { inherit custom; }
          NixwsL
          lf
          manual
        ];
      }
    ]
    ++ [
      {
        hjem.users."${config.custom.meta.user}".imports = with config.flake.modules.hjem; [
          { inherit custom; }
          cat-mocha
          direnv
          fastfetch
          foot
          git
        ];
      }
    ];
}
