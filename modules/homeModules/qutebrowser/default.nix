{
  flake.modules.homeManager.qutebrowser = {
    programs.qutebrowser = {
      enable = true;
    };

    # persist for Impermanence
    customhm.imp.home.cache.files = [
      ".config/qutebrowser/quickmarks"
      ".config/qutebrowser/bookmarks/urls"
    ];
  };
}
