{
  flake.modules.nixos.zerotier =
    { config, ... }:
    {
      # secrets
      sops.secrets."mystuff/zero_net_id".neededForUsers = true;
      sops.secrets."mystuff/zero_net_id" = { };

      sops.secrets."mystuff/zero_net_nixtoks".neededForUsers = true;
      sops.secrets."mystuff/zero_net_nixtoks" = { };

      # module
      services.zerotierone = {
        enable = true;
        joinNetworks = [
          "$(cat ${config.flake.modules.nixos.zerotier.sops.secrets."mystuff/zero_net_id".path})"
        ];
        localConf = {
          settings = {
            softwareUpdate = "disable";
          };
        };
      };
      networking.firewall.allowedTCPPorts = [ 9993 ];
    };
}
