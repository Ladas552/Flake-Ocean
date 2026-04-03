{ modules, ... }:
{
  flake.modules.nixos.copyparty =
    { config, ... }:
    {
      # secrets
      sops.secrets."mystuff/copypartyl" = {
        owner = "copyparty";
        group = "media";
        restartUnits = [ "copyparty.service" ];
      };

      # import module
      imports = [ "${modules.copyparty.src}/contrib/nixos/modules/copyparty.nix" ];

      # module
      services.copyparty = {
        enable = true;
        user = "copyparty";
        group = "media";
        settings = {
          i = "0.0.0.0";
          p = 3210;
        };
        accounts.admin.passwordFile = config.sops.secrets."mystuff/copypartyl".path;
        volumes = {
          "/" = {
            path = "/srv/media/copyparty";
            access.A = "admin";
          };
          "/media" = {
            path = "/srv/media";
            access.A = "admin";
          };
        };
      };

      # Only allow Tailscale
      networking.firewall.interfaces.tailscale0.allowedTCPPorts = [
        config.services.copyparty.settings.p
      ];

      # persist for Impermanence
      custom.imp.root.directories = [
        "/var/lib/copyparty"
      ];
    };
}
