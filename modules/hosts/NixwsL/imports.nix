{ config, ... }:
{
  flake.modules.nixos."hosts/NixwsL".imports =
    with config.flake.modules.nixos;
    [
      NixwsL
      fonts
      imp-options
      sops
      nix
      general
      # Users
      users
      root
      ladas552
    ]
    # Specific Home-Manager modules
    ++ [
      {
        home-manager.users.ladas552.imports = with config.flake.modules.homeManager; [
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
