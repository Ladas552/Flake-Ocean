{
  flake.modules.HM.syncthing = {
    services.syncthing = {
      enable = true;
    };

    # persist for Impermanence
    customhm.imp.home.cache.directories = [ ".local/state/syncthing" ];
  };
}
