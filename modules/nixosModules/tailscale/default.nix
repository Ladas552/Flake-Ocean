{
  flake.modules.nixos.tailscale = args: {
    # secrets
    sops.secrets."mystuff/tailnet".neededForUsers = true;
    sops.secrets."mystuff/tailnet" = { };

    # module
    services.tailscale = {
      enable = true;
      openFirewall = true;
      # expires after 90 days
      authKeyFile = "${args.config.sops.secrets."mystuff/tailnet".path}";
      permitCertUid = "caddy";
    };

    # persist for Impermanence
    custom.imp.root.directories = [ "/var/lib/tailscale/" ];
  };
}
