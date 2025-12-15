{ config, inputs, ... }:
# plugins to add
# - add auto-save-nvim module
# - cord.nvim
# - parinfer-rust
# - module for numb.nvim
{
  perSystem =
    { pkgs, ... }:
    let
      base = with config.flake.modules.nvf; [
        auto-save
        autocmd
        blink-cmp
        cat-mocha
        colorizer
        cyrillic
        dashboard
        diagnostics
        heirline
        keymaps
        lsp-config
        luasnip
        neogit
        neorg
        nix
        numb
        nvim-autopairs
        nvim-surround
        oil
        options
        otter
        rainbow
        snacks
        treesitter
        web-devicons
        which-key
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
                clang
                direnv
                img-clip
                orgmode
                python
                rust
                typst
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
