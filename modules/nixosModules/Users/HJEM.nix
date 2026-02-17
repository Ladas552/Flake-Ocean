{ inputs, config, ... }:
{
  flake.modules.nixos.hjem =
    { pkgs, ... }:
    {
      imports = [ inputs.hjem.nixosModules.default ];
      hjem = {
        # linker = pkgs.smfh;
        linker = inputs.hjem.packages.${pkgs.stdenv.hostPlatform.system}.smfh;
        clobberByDefault = true;
        users.${config.custom.meta.user} = {
          user = "${config.custom.meta.user}";
          directory = "/home/${config.custom.meta.user}";
          # If enabled, can't use home-manager service modules.
          systemd.enable = true;
          rum.environment.hideWarning = true;
        };
      };
    };
}
