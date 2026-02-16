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

      services = {
        tangled = {
          knot = {
            enable = true;
            gitUser = "git";
            stateDir = "/var/lib/tangled-knot";
            repo.scanPath = "${cfg.stateDir}/repos";
            server = {
              listenAddr = "0.0.0.0:5555";
              # hostname = ;
              internalListenAddr = "127.0.0.1:5555";
              owner = "did:plc:5cqzysioqzttihsnbsaxrggu";
            };
          };
          spindle = {
            enable = true;
            server = {
              # listenAddr = "0.0.0.0:${toString ds.port}";
              # hostname = ds.extUrl;
              owner = "did:plc:5cqzysioqzttihsnbsaxrggu";
            };
            pipelines.workflowTimeout = "10m";
          };
        };
      };
    };
}
