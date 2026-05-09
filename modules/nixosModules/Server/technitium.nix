{
  flake.modules.nixos.technitium = {
    # This is propogated for all of my tailscale by making my server a nameserver of the whole network. https://tailscale.com/docs/solutions/block-ads-all-devices-anywhere-using-raspberry-pi
    # I won't use it for creating domain names, just for blocking ads
    # because self signing certs is a manual process that's annoying
    # Also there are no declarative settings for this
    # web ui is under `http://hostname:5380` or `http://ip:5380`
    services.technitium-dns-server = {
      enable = true;
      openFirewall = true;
    };

      # persist for Impermanence
      custom.imp.root.directories = [
        "/var/lib/technitium-dns-server"
      ];
  };
}
