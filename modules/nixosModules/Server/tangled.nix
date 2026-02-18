{ inputs, ... }:
{
  flake.modules.nixos.tangled =
    { config, ... }:
    let
      cfg = config.services.tangled.knot;
    in
    {
      imports = [
        # git
        inputs.tangled.nixosModules.knot
        # UI
        # inputs.tangled.nixosModules.appview
        # CI
        # inputs.tangled.nixosModules.spindle
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
          # My VPS is too weak for docker containers
          # spindle = {
          #   enable = true;
          #   server = {
          #     listenAddr = "0.0.0.0:6555";
          #     hostname = "spindle.ladas552.me";
          #     owner = "did:plc:6ikdlkw64mrjygj6cea62kn4";
          #   };
          #   pipelines.workflowTimeout = "10m";
          # };
        };
      };

      # Reverse proxy
      services.caddy.virtualHosts = {
        "git.ladas552.me".extraConfig = ''
          handle {
            reverse_proxy http://127.0.0.1:3050
          }
        '';
        # "spindle.ladas552.me".extraConfig = ''
        #   handle {
        #     reverse_proxy http://127.0.0.1:6555
        #   }
        # '';
      };

      # persist for Impermanence
      custom.imp.root = {
        directories = [
          "/home/git"
        ];
        cache.directories = [
          # "/var/lib/containers"
          # "/var/log/spindle"
        ];
      };
    };
}
