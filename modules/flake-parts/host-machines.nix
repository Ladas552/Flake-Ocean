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
      collectHostsModules = modules: lib.filterAttrs (name: _: lib.hasPrefix prefix name) modules;
    in
    lib.pipe (collectHostsModules config.flake.modules.nixos) [
      (lib.mapAttrs' (
        name: module:
        let
          specialArgs = {
            inherit inputs;
            hostConfig = module // {
              name = lib.removePrefix prefix name;
            };
          };
        in
        {
          name = lib.removePrefix prefix name;
          value = inputs.nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            modules = module.imports ++ [
              config.flake.modules.nixos.hjem
              config.flake.modules.nixos.homeManager
              {
                home-manager.extraSpecialArgs = specialArgs;
                hjem.specialArgs = specialArgs;
              }
            ];
          };
        }
      ))
    ];

  flake.nixOnDroidConfigurations =
    let
      prefix = "nixOnDroidConfigurations/";
      collectHostsModules = modules: lib.filterAttrs (name: _: lib.hasPrefix prefix name) modules;
    in
    lib.pipe (collectHostsModules config.flake.modules.nixOnDroid) [
      (lib.mapAttrs' (
        name: module:
        let
          droidName = lib.removePrefix prefix name;
        in
        {
          name = droidName;
          value = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
            pkgs = import inputs.nixpkgs { system = "aarch64-linux"; };
            modules = [ module ];
          };
        }
      ))
    ];
}
