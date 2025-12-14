{
  flake.modules.nvf.cyrillic =
    { pkgs, ... }:
    let
      cyrillic = pkgs.vimUtils.buildVimPlugin {
        name = "cyrillic";
        src = pkgs.fetchFromGitHub {
          owner = "nativerv";
          repo = "cyrillic.nvim";
          rev = "86186af29eed2af1a069f9e36140d116a2765c80";
          sha256 = "sha256-B2NjvaKJbkih8HLgFAYVqmTuSKAj7XrCBPVoVpYCXXE=";
        };
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
