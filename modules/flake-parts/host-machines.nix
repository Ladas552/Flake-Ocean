{
  inputs,
  lib,
  config,
  ...
}:
{
  flake.nixosConfigurations =
    let
      prefix = "hosts/";
    in
    lib.pipe config.flake.modules.nixos [
      (lib.filterAttrs (name: _: lib.hasPrefix prefix name))
      (lib.mapAttrs' (
        name: module: {
          name = lib.removePrefix prefix name;
          value = inputs.nixpkgs.lib.nixosSystem {
            modules = [
              module
              config.flake.modules.nixos.hjem
              config.flake.modules.nixos.homeManager
              config.flake.modules.nixos.options
              {
                hjem.extraModules = [
                  inputs.hjem-rum.hjemModules.default
                  config.flake.modules.hjem.options
                  config.flake.modules.hjem.homebrewModules
                ];
                home-manager.sharedModules = [
                  config.flake.modules.homeManager.options
                  config.flake.modules.homeManager.base
                  # minimal as different module only exists because I am not bothered to add minimal = true; to nix-on-droid
                  config.flake.modules.homeManager.homeManager-minimal
                ];
              }
            ];
          };
        }
      ))
    ];

  flake.nixOnDroidConfigurations =
    let
      prefix = "nixOnDroidConfigurations/";
    in
    lib.pipe config.flake.modules.nixOnDroid [
      (lib.filterAttrs (name: _: lib.hasPrefix prefix name))
      (lib.mapAttrs' (
        name: module: {
          name = lib.removePrefix prefix name;
          value = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
            pkgs = import inputs.nixpkgs { system = "aarch64-linux"; };
            modules = [
              module
              config.flake.modules.nixOnDroid.options
            ];
          };
        }
      ))
    ];
}
