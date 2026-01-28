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
      gtk = {

      };
      colors = {
        # single line helix theme to use
        helix-theme = lib.mkOption {
          type = lib.types.str;
          description = "Helix theme to use";
        };
        # define custom colors
        palette = lib.mkOption {
          type = lib.types.attrsOf lib.types.str;
          default = { };
          description = "Colors for theme";
        };
      };
      alias = lib.mkAliasOptionModule [ "color" ] [ "custom" "style" "colors" "palette" ];
    in
    {
      generic.options = {
        options.custom.style = { inherit font colors; };
        imports = [ alias ];
      };
    };
}
