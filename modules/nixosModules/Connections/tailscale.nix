{
  flake.modules.nixos.tailscale =
    { config, ... }:
    {
      # secrets
      sops.secrets."mystuff/tailnet".neededForUsers = true;
      sops.secrets."mystuff/tailnet" = { };

      # module
      services.tailscale = {
        enable = true;
        openFirewall = true;
        # expires after 90 days
        authKeyFile = "${config.sops.secrets."mystuff/tailnet".path}";
        permitCertUid = "caddy";
        disableUpstreamLogging = true;
      };

      # persist for Impermanence
      custom.imp.root.directories = [ "/var/lib/tailscale/" ];
    };
}
