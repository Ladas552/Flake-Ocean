{
  flake.modules.homeManager.direnv =
    { config, modulesPath, ... }:
    {
      imports = [ "${modulesPath}/programs/direnv.nix" ];
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
}
