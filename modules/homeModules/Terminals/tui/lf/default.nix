{
  flake.modules.homeManager.lf =
    { modulesPath, ... }:
    {
      imports = [ "${modulesPath}/programs/lf.nix" ];
      programs.lf = {
        enable = true;
      };

      # persist for Impermanence
      custom.imp.home.cache.directories = [ ".local/share/lf" ];
    };
}
