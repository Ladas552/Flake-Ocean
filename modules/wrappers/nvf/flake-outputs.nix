{ config, inputs, ... }:
# plugins to add
# - autosave plugin
# - cord.nvim
# - parinfer-rust
# - module for numb.nvim
{
  perSystem =
    { pkgs, ... }:
    let
      base = with config.flake.modules.nvf; [
        neorg
        options
        autocmd
        keymaps
        cat-mocha
        diagnostics
        blink-cmp
        luasnip
        colorizer
        dashboard
        heirline
        numb
        which-key
        web-devicons
        rainbow
        cyrillic
        neogit
        nvim-autopairs
        nvim-surround
        oil
        snacks
        nix
        lsp-config
        otter
      ];
    in
    {
      # my nvf config
      packages = {
        nvf-NixPort =
          (inputs.nvf.lib.neovimConfiguration {
            inherit pkgs;
            modules =
              with config.flake.modules.nvf;
              base
              ++ [
                NixPort
                python
                clang
                rust
                typst
                direnv
                img-clip
                orgmode
              ];
          }).neovim;

        nvf-NixMux =
          (inputs.nvf.lib.neovimConfiguration {
            inherit pkgs;
            modules =
              with config.flake.modules.nvf;
              base
              ++ [
                NixMux
              ];
          }).neovim;
      };
    };
}
