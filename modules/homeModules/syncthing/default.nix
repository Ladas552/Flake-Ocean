{
  flake.modules.homeManager.syncthing = {
    services.syncthing = {
      enable = true;
    };

    # persist for Impermanence
    custom.imp.home.cache.directories = [ ".local/state/syncthing" ];
  };
}
