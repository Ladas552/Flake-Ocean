{
  flake.modules.homeManager.base = {
    # Me
    home.username = "ladas552";
    home.homeDirectory = "/home/ladas552";
    # Environment and Dependencies
    xdg = {
      enable = true;
    };
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    programs.man.enable = false;
  };
}
