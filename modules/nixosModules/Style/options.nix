{ lib, ... }:
{
  # define options to use for styling
  flake.modules =
    let
      font = {
        package = lib.mkPackageOption { description = "Package for font to install"; };
        name = lib.mkOption {
          type = lib.types.str;
          description = "Name for the font it install";
        };
        font-family = lib.mkOption {
          type = lib.types.str;
          description = "Name for the font it install";
        };
      };
    in
    {
      nixos.options = {
        options.custom.style = { inherit font; };
      };
      homeManager.options = {
        options.custom.style = { inherit font; };
      };
      hjem.options = {
        options.custom.style = { inherit font; };
      };
    };
}
