{ config, ... }:
let
  custom.meta = {
    hostname = "NixMux";
    self = "/data/data/com.termux.nix/files/home/git/Flake-Ocean";
    isTermux = true;
    norg = "~/storage/downloads/Norg";
  };
in
{
  flake.modules.nixvim.NixMux.imports = [ { inherit custom; } ];
  flake.modules.nvf.NixMux.imports = [ { inherit custom; } ];
  flake.modules.nixOnDroid."nixOnDroidConfigurations/NixMux".imports =
    with config.flake.modules.nixOnDroid;
    [
      { inherit custom; }
      base
      fish
    ]
    ++ [
      {
        home-manager.config.imports = with config.flake.modules.homeManager; [
          { inherit custom; }
          config.flake.modules.generic.options
          NixMux
          nvf
          fastfetch
          gh
          git
          helix
          lf
        ];
      }
    ];
}
