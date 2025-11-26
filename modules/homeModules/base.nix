{
  flake.modules.homeManager.base =
    { config, modulesPath, ... }:
    {
      imports = [
        "${modulesPath}/programs/home-manager.nix"
        "${modulesPath}/programs/man.nix"
      ];
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
    };
}
