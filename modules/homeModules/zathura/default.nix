{
  flake.modules.homeManager.zathura =
    { modulesPath, ... }:
    {
      imports = [ "${modulesPath}/programs/zathura.nix" ];
      programs.zathura = {
        enable = true;
        mappings = {
          "i" = "recolor";
        };
      };

      # persist for Impermanence
      custom.imp.home.cache.directories = [ ".local/share/zathura" ];
    };
}
