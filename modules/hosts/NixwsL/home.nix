{
  flake.modules.homeManager.NixwsL =
    { pkgs, lib, ... }:
    {
      # WSL isn't goot with switch for some reason
      home.shellAliases = {
        yy = lib.mkForce "nh os boot /home/ladas552/Nix-Is-Unbreakable";
        yyy = lib.mkForce "nh os boot -u /home/ladas552/Nix-Is-Unbreakable";
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
