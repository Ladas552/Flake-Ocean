{
  flake.modules.homeManager.qutebrowser = {
    programs.qutebrowser = {
      enable = true;
    };

    # persist for Impermanence
    custom.imp.home.cache.files = [
      ".config/qutebrowser/quickmarks"
      ".config/qutebrowser/bookmarks/urls"
    ];
  };
}
