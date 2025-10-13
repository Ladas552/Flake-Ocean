{
  flake.modules.homeManager.lf = {
    programs.lf = {
      enable = true;
    };

    # persist for Impermanence
    customhm.imp.home.cache.directories = [ ".local/share/lf" ];
  };
}
