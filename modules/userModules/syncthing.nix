{
  flake.modules =
    let
      config-syncthing = {
        services.syncthing.enable = true;
        # persist for Impermanence
        custom.imp.home.cache.directories = [ ".local/state/syncthing" ];
      };
    in
    {
      homeManager.syncthing = config-syncthing;
      # homeBrew module
      hjem.syncthing = config-syncthing;
    };
}
