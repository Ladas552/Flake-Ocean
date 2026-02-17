{ modules, ... }:
{
  flake.modules.nixos.tangled =
    { config, ... }:
    let
      cfg = config.services.tangled.knot;
    in
    {
      imports = [
        # git
        "${modules.tangled.src}/nix/modules/knot.nix"
        # UI
        "${modules.tangled.src}/nix/modules/appview.nix"
        # CI
        "${modules.tangled.src}/nix/modules/spindle.nix"
      ];

      # module
      services = {
        tangled = {
          knot = {
            enable = true;
            gitUser = "git";
            stateDir = "/var/lib/tangled-knot";
            repo.scanPath = "${cfg.stateDir}/repos";
            server = {
              listenAddr = "0.0.0.0:3050";
              hostname = "git.ladas552.me";
              internalListenAddr = "127.0.0.1:5555";
              owner = "did:plc:6ikdlkw64mrjygj6cea62kn4"; # @ladas552.me
            };
          };
          # spindle = {
          #   enable = true;
          #   server = {
          # listenAddr = "0.0.0.0:${toString ds.port}";
          # hostname = ds.extUrl;
          #     owner = "did:plc:6ikdlkw64mrjygj6cea62kn4";
          #   };
          #   pipelines.workflowTimeout = "10m";
          # };
        };
      };

      # Reverse proxy
      services.caddy.virtualHosts."git.ladas552.me" = {
        extraConfig = ''
          handle {
            reverse_proxy http://127.0.0.1:3050
          }
        '';
      };

      # persist for Impermanence
      custom.imp.root.directories = [ "/var/lib/tangled-knot" ];
    };
}
