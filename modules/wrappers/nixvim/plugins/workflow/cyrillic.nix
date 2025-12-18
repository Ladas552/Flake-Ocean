{ self, ... }:
{
  flake.modules.nixvim.cyrillic =
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
      extraPlugins = [ cyrillic ];
      extraConfigLua = # lua
        ''
          require('cyrillic').setup{
            no_cyrillic_abbrev = true,
          }
        '';
    };
}
