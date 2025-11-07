{
  flake.modules.homeManager.direnv =
    { config, ... }:
    {
      programs.direnv = {
        enable = true;
        silent = true;
        nix-direnv.enable = true;
        config = {
          global = {
            warn_timeout = "0";
            hide_env_diff = true;
          };
          whitelist.prefix = [ "/home/${config.custom.meta.user}/Projects" ];
        };
      };
    };
}
