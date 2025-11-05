{
  flake.modules.homeManager.lf = {
    programs.lf = {
      enable = true;
    };

    # persist for Impermanence
    custom.imp.home.cache.directories = [ ".local/share/lf" ];
  };
}
