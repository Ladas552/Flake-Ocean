{
  flake.modules.homeManager.syncthing =
    { modulesPath, ... }:
    {
      imports = [ "${modulesPath}/services/syncthing.nix" ];
      services.syncthing.enable = true;
      # persist for Impermanence
      custom.imp.home.cache.directories = [ ".local/state/syncthing" ];
    };
}
