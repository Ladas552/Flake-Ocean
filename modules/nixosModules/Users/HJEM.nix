{ inputs, config, ... }:
{
  flake.modules.nixos.hjem =
    { pkgs, ... }:
    {
      imports = [ inputs.hjem.nixosModules.default ];
      hjem = {
        linker = inputs.hjem.packages.${pkgs.stdenv.hostPlatform.system}.smfh;
        clobberByDefault = true;
        users.${config.custom.meta.user} = {
          user = "${config.custom.meta.user}";
          directory = "/home/${config.custom.meta.user}";
          # Only because systemd of hjem is readonly, while home-manager it's a writable directory
          systemd.enable = false;
          rum.environment.hideWarning = true;
        };
      };
    };
}
