{
  flake.modules.homeManager.zathura = {
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
