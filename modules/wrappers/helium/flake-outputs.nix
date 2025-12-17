{ self, ... }:
{
  perSystem =
    {
      pkgs,
      system,
      lib,
      ...
    }:
    let
      sources = pkgs.callPackage "${self}/_sources/generated.nix" { };
      # wrapper from @Michael-C-Buckley
      heliumModule = import "${sources.helium-wrapped.src}/packages/helium.nix" {
        inputs = {
          jail = {
            lib = jail-nix;
          };
        };
      };

      # dependencies
      jail-nix = pkgs.callPackage sources.jail-nix.src { };

      overriddenPkgs = pkgs // {
        # use sources.helium in my nvfetcher config instead of the one used in the wrapper
        callPackage = _: _: sources;
      };

      heliumPkgs = heliumModule.perSystem {
        pkgs = overriddenPkgs;
        inherit system lib;
      };

    in
    {
      packages.helium = heliumPkgs.packages.helium-jailed;
    };
}
