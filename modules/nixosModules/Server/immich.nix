{
  flake.modules.nixos.immich = {
    # modules
    services.immich = {
      enable = true;
      openFirewall = false; # Only allow specific ports for specific networks
      host = "100.74.112.27";
      machine-learning.enable = false; # Doesn't seem to work on my nvidia 860m
    };
    # Only allow Tailscale
    networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 2283 ];
  };
}
