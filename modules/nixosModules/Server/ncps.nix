{
  flake.modules.nixos.ncps = {
    # proxy cache across all systems on the network
    services.ncps = {
      enable = true;
      cache.hostName = "100.74.112.27";
      upstream = {
        publicKeys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
        caches = [ "https://cache.nixos.org" ];
      };
    };
    # Only allow Tailscale
    networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 8501 ];
  };
}
