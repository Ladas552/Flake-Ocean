{ config, ... }:
{
  flake.modules.hjem.homebrewModules.imports = with config.flake.modules.hjem; [
    mpris-proxy-brew
    mpd-brew
    mpdris2-brew
    syncthing-brew
    userDirs-brew
  ];
}
