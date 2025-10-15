{
  flake.modules.homeManager.NixVm =
    { pkgs, ... }:
    {
      # Me
      home.username = "ladas552";
      home.homeDirectory = "/home/ladas552";
      # Don't change
      home.stateVersion = "23.11"; # Please read the comment before changing.
      # Standalone Packages for user
      home.packages = with pkgs; [
        #pgks-master.
        libqalculate
        lshw
        gparted
      ];

      xdg = {
        enable = true;
      };

      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;
    };
}
