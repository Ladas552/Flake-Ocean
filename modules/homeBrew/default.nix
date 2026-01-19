{ config, ... }:
{
  flake.modules.hjem.homebrewModules.imports = [ config.flake.modules.hjem.mpris-proxy-brew ];
}
