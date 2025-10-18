{
  flake.modules.homeManager.NixVm =
    { pkgs, ... }:
    {
      # Don't change
      home.stateVersion = "23.11"; # Please read the comment before changing.
      # Standalone Packages for user
      home.packages = with pkgs; [
        #pgks-master.
        libqalculate
        lshw
        gparted
      ];
    };
}
