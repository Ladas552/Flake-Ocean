{
  flake.modules.nixos.dashboard = {
    # caddy
    services.caddy.virtualHosts."nixtoks.taila7a93b.ts.net" = {
      extraConfig = ''
        reverse_proxy localhost:8082
      '';
    };

    # modules
    services.homepage-dashboard = {
      enable = true;
      allowedHosts = "nixtoks.taila7a93b.ts.net";
      settings = { };
      widgets = [
        {
          resources = {
            cpu = true;
            cputemp = true;
            uptime = true;
            disk = "/";
            memory = true;
          };
        }
        {
          resources = {
            label = "HDD";
            disk = "/mnt/zmedia";
          };
        }
        {
          search = {
            provider = "custom";
            url = "http://100.74.112.27:3038/search?q=";
            target = "_blank";
          };
        }
      ];
      services = [
        {
          "Share/Download files" = [
            {
              "Immich" = {
                description = "Photos";
                href = "http://100.74.112.27:2283";
              };
            }
            {
              "NextCloud" = {
                description = "Drive";
                href = "http://100.74.112.27:8080";
              };
            }
            {
              "Qbittorrent" = {
                description = "Torrents";
                href = "http://100.74.112.27:8081";
              };
            }
            {
              "Karakeep" = {
                description = "Bookmark manager";
                href = "http://100.74.112.27:9221";
              };
            }
          ];
        }
        {
          "Media" = [
            {
              "Jellyfin" = {
                description = "Watch";
                href = "http://100.74.112.27:8096";
              };
            }

            {
              "Kavita" = {
                description = "Books";
                href = "http://100.74.112.27:5000";
              };
            }
            {
              "Miniflux" = {
                description = "RSS feed";
                href = "http://100.74.112.27:8067";
              };
            }
            {
              "Open-WebUI" = {
                description = "My Ollama instance";
                href = "http://100.74.112.27:1212";
              };
            }
          ];
        }
        {
          "Doesn't work" = [
            {
              "Sonarr" = {
                description = "TV Shows";
                href = "http://100.74.112.27:8989";
              };
            }
            {
              "Radarr" = {
                description = "Movies";
                href = "http://100.74.112.27:7878";
              };
            }
          ];
        }

      ];
      bookmarks = [ ];

    };
    # Only allow Tailscale
    networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 8082 ];
  };
}
