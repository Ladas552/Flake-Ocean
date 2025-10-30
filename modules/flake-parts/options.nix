{ lib, ... }:
{
  # setting user here because can't access it out of modules scope, eg in imports.nix
  # It means I can't set it per host, but at least I can change my username pretty easy if need be
  options.custom.meta.user = lib.mkOption {
    type = lib.types.str;
    default = "ladas552";
    description = "Normal user in wheel group";
  };
  config.flake.modules =
    let
      isTermux = lib.mkOption {
        type = lib.types.bool;
        description = "Is host nixOnDroid";
      };
      hostname = lib.mkOption {
        type = lib.types.str;
        description = "Hostname";
      };
      self = lib.mkOption {
        type = lib.types.str;
        description = "Absolute path to location of the flake";
      };
      norg = lib.mkOption {
        type = lib.types.anything;
        description = "Path to Norg notes";
      };
    in
    {
      nixos.base = {
        # custom options, can be called as config.custom.meta.<option> in modules
        options.custom.meta = {
          inherit
            isTermux
            hostname
            self
            norg
            ;
        };
      };
      homeManager.base = {
        # custom options, can be called as config.custom.meta.<option> in modules
        options.custom.meta = {
          inherit
            isTermux
            hostname
            self
            norg
            ;
        };
      };

      hjem.base = {
        # custom options, can be called as config.custom.meta.<option> in modules
        options.custom.meta = {
          inherit
            isTermux
            hostname
            self
            norg
            ;
        };
      };

      nixOnDroid.base = {
        # custom options, can be called as config.custom.meta.<option> in modules
        options.custom.meta = {
          inherit
            isTermux
            hostname
            self
            norg
            ;
        };
      };
    };
}
