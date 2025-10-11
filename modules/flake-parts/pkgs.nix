{
  inputs,
  withSystem,
  ...
}:
{
  imports = [ ../../pkgs ];
  perSystem =
    { system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    };

  flake = {
    overlays.default =
      _final: prev:
      withSystem prev.stdenv.hostPlatform.system (
        { config, ... }:
        {
          customPkg = config.packages;
        }
      );
  };
}
