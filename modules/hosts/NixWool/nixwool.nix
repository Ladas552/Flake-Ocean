{
  flake.modules = {
    nixos.NixWool =
      { pkgs, lib, ... }:
      {
        nix = {
          buildMachines = [
            {
              hostName = "NixToks";
              sshUser = "ladas552";
              protocol = "ssh-ng";
              systems = [
                "x86_64-linux"
                "aarch64-linux"
              ];
              maxJobs = 16;
              speedFactor = 6;
              supportedFeatures = [
                "big-parallel"
                "kvm"
                "nixos-test"
              ];
            }
          ];
        };
        # Standalone Packages
        environment.systemPackages = with pkgs; [
          libqalculate
          lshw
        ];

        # Environmental Variables
        environment.variables = {
          NIX_REMOTE = "daemon";
        };

        services.sshguard.enable = true;
        services.caddy = {
          enable = true;
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
