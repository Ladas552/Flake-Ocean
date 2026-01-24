{
  flake.modules.homeManager.base =
    { config, ... }:
    {
      # Me
      home.username = "${config.custom.meta.user}";
      home.homeDirectory = "/home/${config.custom.meta.user}";
      # Environment and Dependencies
      xdg = {
        enable = true;
      };
      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;

      programs.man.enable = false;

      # I use hjem for user services
      systemd.user.enable = false;
    };
}
