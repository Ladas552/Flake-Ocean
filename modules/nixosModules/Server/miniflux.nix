{
  flake.modules.nixos.miniflux =
    { config, ... }:
    {
      # secrets
      sops.secrets."mystuff/minifluxl" = { };
      sops.secrets."mystuff/minifluxp" = { };
      sops.templates."miniflux-admin-credentials".content = ''
        ADMIN_USERNAME="${config.sops.placeholder."mystuff/minifluxl"}"
        ADMIN_PASSWORD="${config.sops.placeholder."mystuff/minifluxp"}"
      '';

      # module
      services.miniflux = {
        enable = true;
        adminCredentialsFile = "${config.sops.templates."miniflux-admin-credentials".path}";
        config = {
          LISTEN_ADDR = "100.74.112.27:8067";
          CREATE_ADMIN = true;
          LOG_DATE_TIME = "1";

          FETCH_BILIBILI_WATCH_TIME = "1";
          FETCH_NEBULA_WATCH_TIME = "1";
          FETCH_ODYSEE_WATCH_TIME = "1";
          FETCH_YOUTUBE_WATCH_TIME = "1";

        };
      };
      # Only allow Tailscale
      networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 8067 ];
    };
}
