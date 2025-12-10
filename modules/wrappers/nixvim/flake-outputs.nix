# the concept of using nixvim as standalone but with module imports was stolen from
# MightyIam https://github.com/mightyiam/infra/blob/baffce8fd4e852789c67fc487c113ff3742d6f19/modules/nixvim/flake-outputs.nix
{
  config,
  ...
}:
{
  perSystem =
    { inputs', pkgs, ... }:
    {
      packages.nixvim-NixPort = inputs'.nixvim.legacyPackages.makeNixvimWithModule {
        inherit pkgs;
        module = config.flake.modules.nixvim.NixPort;
      };

      packages.nixvim-NixMux = inputs'.nixvim.legacyPackages.makeNixvimWithModule {
        inherit pkgs;
        module = config.flake.modules.nixvim.NixMux;
      };
    };
}
