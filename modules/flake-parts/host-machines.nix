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
              inputs.home-manager.nixosModules.home-manager
              inputs.hjem.nixosModules.default
              {
                home-manager.extraSpecialArgs = specialArgs;
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
