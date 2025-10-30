{ config, ... }:
{
  flake.modules.hjem.direnv = {
    rum.programs.direnv = {
      enable = true;
      integrations = {
        nix-direnv.enable = true;
        fish.enable = true;
      };
      settings = {
        global = {
          # the same as direnv.silent in Home-manager
          log_format = "-";
          log_filter = "^$";
          # hide useless text
          warn_timeout = "0";
          hide_env_diff = true;
        };
        whitelist.prefix = [ "/home/${config.custom.meta.user}/Projects" ];
      };
    };
  };
}
