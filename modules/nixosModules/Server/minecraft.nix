{ modules, ... }:
{
  flake.modules.nixos = {
    minecraft-server =
      { pkgs, ... }:
      {
        # module
        imports = [ "${modules.nix-minecraft.src}/modules/minecraft-servers.nix" ];
        nixpkgs.overlays = [
          (import "${modules.nix-minecraft.src}/overlay.nix")
        ];

        services.minecraft-servers = {
          enable = true;
          eula = true;
          servers.paper = {
            enable = true;
            package = pkgs.paperServers.paper-1_21_11;
            autoStart = true;
            enableReload = true;
            # https://docs.papermc.io/paper/aikars-flags/
            jvmOpts = "-Xms4G -Xmx6G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true";
            serverProperties = {
              accepts-transfers = false;
              allow-flight = false;
              broadcast-console-to-ops = true;
              broadcast-rcon-to-ops = false;
              difficulty = "hard";
              enable-code-of-conduct = false;
              enable-jmx-monitoring = false;
              enable-query = false;
              enable-rcon = true;
              # please don't hack me
              "rcon.password" = "password";
              enable-status = true;
              enforce-secure-profile = false;
              enforce-whitelist = false;
              entity-broadcast-range-percentage = 100;
              force-gamemode = false;
              function-permission-level = 2;
              gamemode = "survival";
              generate-structures = true;
              hardcore = false;
              hide-online-players = false;
              initial-enabled-packs = "vanilla";
              level-name = "world";
              log-ips = true;
              max-chained-neighbor-updates = 1000000;
              max-players = 20;
              max-tick-time = 60000;
              max-world-size = 29999984;
              motd = "Boyz server: No backups, no keepInventory, Hard";
              network-compression-threshold = 256;
              online-mode = false;
              op-permission-level = 4;
              pause-when-empty-seconds = 60;
              player-idle-timeout = 0;
              prevent-proxy-connections = false;
              rate-limit = 0;
              region-file-compression = "deflate";
              server-port = "25565";
              simulation-distance = 10;
              spawn-protection = 16;
              status-heartbeat-interval = 0;
              sync-chunk-writes = true;
              use-native-transport = true;
              view-distance = 12;
              white-list = false;
            };
          };
        };

        # Only allow Tailscale
        networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 25565 ];

        # persist for Impermanence
        custom.imp.root.directories = [ "/srv/minecraft" ];
      };
    minecraft-relay = {
      services.haproxy = {
        enable = true;
        config = ''
          defaults
                  mode tcp
                  log global
                  retries 3
                  timeout connect 5s
                  timeout client 2h
                  timeout server 2h

          frontend minecraft_front
                  bind *:25565
                  mode tcp
                  default_backend minecraft_back

          backend minecraft_back
                  mode tcp
                  server mc 100.74.112.27:25565 check
        '';
      };
      # Reverse proxy
      services.caddy.virtualHosts."minecraft.ladas552.me" = {
        extraConfig = ''
          handle {
            reverse_proxy http://127.0.0.1:25565
          }
        '';
      };
    };
  };
}
