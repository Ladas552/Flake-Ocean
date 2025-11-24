{ lib, ... }:
{
  # define options to use for styling
  flake.modules =
    let
      font = {
        name = lib.mkOption {
          type = lib.types.str;
          description = "Name for the font it install";
        };
        font-family = lib.mkOption {
          type = lib.types.str;
          description = "Name for the font it install";
        };
      };
      colors = {
        helix-theme = lib.mkOption {
          type = lib.types.str;
          description = "helix theme to use";
        };
      };
    in
    {
      nixos.options = {
        options.custom.style = { inherit font colors; };
      };
      homeManager.options = {
        options.custom.style = { inherit font colors; };
      };
      hjem.options = {
        options.custom.style = { inherit font colors; };
      };
    };
}
