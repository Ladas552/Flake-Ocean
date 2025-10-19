{
  flake.modules.nixos.jellyfin = {
    services.jellyfin = {
      enable = true;
      group = "media";
    };
    users.users."jellyfin".extraGroups = [ "media" ];
    # Only allow Tailscale
    networking.firewall.interfaces.tailscale0.allowedTCPPorts = [
      8096
      8920
    ];
  };
}
