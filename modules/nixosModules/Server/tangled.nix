{ inputs, ... }:
{
  flake.modules.nixos.tangled =
    { config, lib, ... }:
    let
      cfg = config.services.tangled.knot;
    in
    {
      imports = [
        # git
        inputs.tangled.nixosModules.knot
        # UI
        inputs.tangled.nixosModules.appview
        # CI
        inputs.tangled.nixosModules.spindle
      ];

      # module
      services = {
        tangled = {
          knot = {
            enable = true;
            gitUser = "git";
            repo.scanPath = "${cfg.stateDir}/repos";
            server = {
              listenAddr = "0.0.0.0:3050";
              hostname = "git.ladas552.me";
              internalListenAddr = "127.0.0.1:5444";
              owner = "did:plc:6ikdlkw64mrjygj6cea62kn4"; # @ladas552.me
            };
          };
          spindle = {
            enable = true;
            server = {
              listenAddr = "0.0.0.0:6555";
              hostname = "spindle.ladas552.me";
              owner = "did:plc:6ikdlkw64mrjygj6cea62kn4";
            };
            pipelines.workflowTimeout = "10m";
          };
        };
      };

      # use podman instead of docker for spindle
      virtualisation.podman = {
        enable = true;
        # create a `docker` alias for podman, to use it as a drop-in replacement
        dockerCompat = true;
        # required for containers under podman-compose to be able to talk to each other.
        defaultNetwork.settings.dns_enabled = true;
      };

      virtualisation.docker.enable = lib.mkForce false;

      # Reverse proxy
      services.caddy.virtualHosts = {
        "git.ladas552.me".extraConfig = ''
          handle {
            reverse_proxy http://127.0.0.1:3050
          }
        '';
        "spindle.ladas552.me".extraConfig = ''
          handle {
            reverse_proxy http://127.0.0.1:6555
          }
        '';
      };

      # persist for Impermanence
      custom.imp.root = {
        directories = [
          "/home/git"
        ];
        cache.directories = [
          "/var/lib/containers"
          "/var/log/spindle"
        ];
      };
    };
}
