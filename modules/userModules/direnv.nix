{
  flake.modules = {
    homeManager.direnv =
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
            whitelist.prefix = [
              "/persist/home/${config.custom.meta.user}/Projects"
              "/home/${config.custom.meta.user}/Projects"
            ];
          };
        };
      };
    hjem.direnv =
      { config, ... }:
      {
        rum.programs.direnv = {
          enable = true;
          integrations.nix-direnv.enable = true;
          settings = {
            global = {
              # the same as direnv.silent in Home-manager
              log_format = "-";
              log_filter = "^$";
              # hide useless text
              warn_timeout = "0";
              hide_env_diff = true;
            };
            whitelist.prefix = [
              "/persist/home/${config.custom.meta.user}/Projects"
              "/home/${config.custom.meta.user}/Projects"
            ];
          };
        };
      };
  };
}
