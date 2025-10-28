{ config, ... }:
let
  custom.meta = {
    hostname = "NixMux";
    self = "/data/data/com.termux.nix/files/home/Nix-Is-Unbreakable";
    isTermux = true;
    norg = "~/storage/downloads/Norg";
  };
in
{
  flake.modules.nixOnDroid."nixOnDroidConfigurations/NixMux".imports =
    with config.flake.modules.nixOnDroid; [
      { inherit custom; }
      base
    ];
}
