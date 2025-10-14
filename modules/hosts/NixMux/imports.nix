{ config, ... }:
{
  flake.modules.nixOnDroid."nixOnDroidConfigurations/NixMux".imports =
    with config.flake.modules.nixOnDroid; [
      base
    ];
}
