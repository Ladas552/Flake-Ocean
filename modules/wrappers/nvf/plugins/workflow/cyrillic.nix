{ self, ... }:
{
  flake.modules.nvf.cyrillic =
    { pkgs, ... }:
    let
      # nvfetcher pins
      sources = pkgs.callPackage "${self}/_sources/generated.nix" { };
      cyrillic = pkgs.vimUtils.buildVimPlugin {
        name = "cyrillic";
        src = sources.cyrillic.src;
      };
    in
    {
      vim.extraPlugins = {
        "cyrillic".package = cyrillic;
        "cyrillic".setup = # lua
          ''
            require('cyrillic').setup{
              no_cyrillic_abbrev = true,
            }
          '';
      };
    };
}
