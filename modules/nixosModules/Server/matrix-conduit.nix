{
  # settings and well-known is stolen from @poz https://git.poz.pet/poz/niksos/src/commit/ca0170d49dcf01b9318e0eaaddf0a0e92aab5c74/hosts/szparag/services/conduit.nix
  flake.modules.nixos = {
    matrix-conduit = {
      services.matrix-conduit = {
        enable = true;
        settings.global = {
          address = "0.0.0.0";
          server_name = "ladas552.me";
          database_backend = "rocksdb";
          port = 6161;
          enable_lightning_bolt = false;
          max_request_size = 104857600;
          allow_check_for_updates = false;
          allow_registration = false;
        };
      };
      # Only allow Tailscale
      networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 6161 ];

      # persist for Impermanence
      custom.imp.root.directories = [ "/var/lib/matrix-conduit" ];
    };
    matrix-relay = {
      services = {
        nginx = {
          enable = true;
          streamConfig = ''
            server {
              listen 6161;
              proxy_pass 100.74.112.27:6161;
            }
          '';
        };

        caddy.virtualHosts = {
          "matrix.ladas552.me".extraConfig = ''
            reverse_proxy /_matrix/* http://127.0.0.1:6161
          '';
          "ladas552.me".extraConfig = ''
            header /.well-known/matrix/* Content-Type application/json
            header /.well-known/matrix/* Access-Control-Allow-Origin *

            respond /.well-known/matrix/server `{
                "m.server": "matrix.ladas552.me:443"
            }`
            respond /.well-known/matrix/client `{
                "m.homeserver": {
                    "base_url": "https://matrix.ladas552.me"
                },
                "m.identity_server": {
                    "base_url": "https://matrix.org"
                },
                "org.matrix.msc3575.proxy": {
                    "url": "https://matrix.ladas552.me"
                }
            }`
          '';
        };
      };

      networking.firewall.allowedTCPPorts = [
        443
        6161
      ];
    };
  };
}
