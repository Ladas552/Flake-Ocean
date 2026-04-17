{
  flake.modules.nixos.kavita =
    { config, ... }:
    {
      # secrets
      sops.secrets."mystuff/kavita".neededForUsers = true;
      sops.secrets."mystuff/kavita" = { };
      # module
      services.kavita = {
        enable = true;
        tokenKeyFile = config.sops.secrets."mystuff/kavita".path;
      };
      # Only allow Tailscale
      networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 5000 ];
      users.users."kavita".extraGroups = [ "media" ];
    };
}
