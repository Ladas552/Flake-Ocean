{
  inputs,
  lib,
  config,
  ...
}:
{
  flake =
    let
      prefix = "hosts/";
    in
    {
      nixosConfigurations = lib.pipe config.flake.modules.nixos [
        (lib.filterAttrs (name: _: lib.hasPrefix prefix name))
        (lib.mapAttrs' (
          name: module: {
            name = lib.removePrefix prefix name;
            value = inputs.nixpkgs.lib.nixosSystem {
              modules = [
                module
                config.flake.modules.nixos.hjem
                config.flake.modules.nixos.homeManager
                config.flake.modules.generic.options
                {
                  hjem.extraModules = [
                    inputs.hjem-rum.hjemModules.default
                    config.flake.modules.generic.options
                    config.flake.modules.hjem.homebrewModules
                  ];
                  home-manager.sharedModules = [
                    config.flake.modules.generic.options
                    config.flake.modules.homeManager.base
                  ];
                }
              ];
            };
          }
        ))
      ];
    };
}
