{
  flake.modules.homeManager.NixwsL =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      # WSL isn't goot with switch for some reason
      home.shellAliases = {
        yy = lib.mkForce "nh os boot ${config.custom.meta.self}";
        yyy = lib.mkForce "nh os boot -u ${config.custom.meta.self}";
      };
      # Don't change
      home.stateVersion = "24.05"; # Please read the comment before changing.
      # Standalone Packages for user
      home.packages = with pkgs; [
        libqalculate
        typst
      ];

      home.sessionVariables = lib.mkForce {
        EDITOR = "nvim";
        VISUAL = "nvim";
        SUDO_EDITOR = "nvim";
      };
    };
}
