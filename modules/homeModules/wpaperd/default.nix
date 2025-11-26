{
  flake.modules.homeManager.wpaperd =
    { modulesPath, config, ... }:
    {
      imports = [ "${modulesPath}/services/wpaperd.nix" ];
      services.wpaperd = {
        enable = true;
        settings = {
          eDP-1 = {
            path = "${config.xdg.userDirs.pictures}/backgrounds";
            sorting = "random";
            duration = "10m";
          };
        };
      };
    };
}
