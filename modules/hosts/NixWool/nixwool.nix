{
  flake.modules = {
    nixos.NixWool =
      { pkgs, lib, ... }:
      {
        nix = {
          distributedBuilds = true;
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
          globalConfig = ''
            email me@ladas552.me
          '';
          virtualHosts = {
            "blog.ladas552.me" = {
              extraConfig = ''
                handle {
                  reverse_proxy http://127.0.0.1:1313
                }
                root * /home/ladas552/sites/blog/public
                encode gzip
              '';
            };
            "nix.ladas552.me" = {
              extraConfig = ''
                handle {
                  reverse_proxy http://127.0.0.1:3131
                }
                root * /home/ladas552/sites/nix/public
                encode gzip
              '';
            };
          };
        };

        # ZFS needs it
        networking.hostId = "fcb8b0b0";

        # No
        system.stateVersion = "26.05"; # Did you read the comment?

        #  It's a 2 vCPU server
        nix.settings = {
          cores = lib.mkForce 1;
          max-jobs = lib.mkForce 1;
        };

        # I don't have firewall enabled, firewall is managed by hetzner, but just to be sure I added these ports
        networking.firewall.allowedTCPPorts = [
          80
          443
          22
          3000
        ];
        networking.firewall.allowedUDPPorts = [
          443
          22
        ];

        custom.imp.home.directories = [
          "sites"
        ];
      };
    homeManager.NixWool = {
      # Don't change
      home.stateVersion = "26.05"; # Please read the comment before changing.
    };
  };
}
