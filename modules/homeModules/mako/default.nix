{
  flake.modules.homeManager.mako =
    { modulesPath, ... }:
    {
      imports = [ "${modulesPath}/services/mako.nix" ];
      services.mako = {
        enable = true;
        settings = {
          layer = "overlay";
          default-timeout = 5000;
          height = 1000;
        };
      };
    };
}
