{ lib, config, ... }:
{
  # setting user here because can't access it out of modules scope, eg in imports.nix
  options.custom.meta.user = lib.mkOption {
    type = lib.types.str;
    default = "ladas552";
    description = "Normal user in wheel group";
  };
  config.flake.modules =
    let
      user = lib.mkOption {
        type = lib.types.str;
        default = config.custom.meta.user;
      };
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
      generic.options = {
        # custom options, can be called as config.custom.meta.<option> in modules
        options.custom.meta = {
          inherit
            user
            isTermux
            hostname
            self
            norg
            ;
        };
      };
    };
}
