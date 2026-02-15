{
  flake.modules = {
    nixos.NixWool =
      { pkgs, lib, ... }:
      {
        # Standalone Packages
        environment.systemPackages = with pkgs; [
          libqalculate
          lshw
        ];

        # Environmental Variables
        environment.variables = {
        };

        # ZFS needs it
        networking.hostId = "fcb8b0b0";

        system.stateVersion = "26.05"; # Did you read the comment?

        #  It's a 2 vCPU server
        nix.settings = {
          cores = lib.mkForce 1;
          max-jobs = lib.mkForce 1;
        };

        custom.imp.home.directories = [
        ];
      };
    homeManager.NixWool = {
      # Don't change
      home.stateVersion = "26.05"; # Please read the comment before changing.
    };
  };
}
