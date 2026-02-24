{
  flake.modules = {
    nixos.NixWool =
      {
        pkgs,
        lib,
        config,
        ...
      }:
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
        # I chowned this directories `sudo chown -R ladas552:caddy /var/www`
        users.users."${config.custom.meta.user}".extraGroups = [ "caddy" ];
        services.caddy = {
          enable = true;
          globalConfig = ''
            email me@ladas552.me
          '';
          virtualHosts = {
            "blog.ladas552.me" = {
              extraConfig = ''
                root * /var/www/blog
                file_server
                encode gzip
              '';
            };
            "nix.ladas552.me" = {
              extraConfig = ''
                root * /var/www/nix
                file_server
                encode gzip
              '';
            };
            "ladas552" = {
              extraConfig = ''respond "Blog: https://blog.ladas552.me Nix-Docs: https://nix.ladas552.me Git-Hosting: https://tangled.org/did:plc:6ikdlkw64mrjygj6cea62kn4 GitHub: https://github.com/          Ladas552"'';
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

        environment.persistence."/cache".directories = [
          {
            directory = "/var/www";
            mode = "0755";
            user = "ladas552";
            group = "caddy";
          }
        ];
      };
    homeManager.NixWool = {
      # Don't change
      home.stateVersion = "26.05"; # Please read the comment before changing.
    };
  };
}
