{ config, ... }:
let
  custom.meta = {
    hostname = "NixMux";
    self = "/data/data/com.termux.nix/files/home/Flake-Ocean";
    isTermux = true;
    norg = "~/storage/downloads/Norg";
  };
in
{
  flake.modules.nixvim.nixvim-NixMux.imports = [ { inherit custom; } ];
  flake.modules.nixOnDroid."nixOnDroidConfigurations/NixMux".imports =
    with config.flake.modules.nixOnDroid; [
      { inherit custom; }
      base
    ];
}
