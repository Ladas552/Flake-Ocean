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
        numb
        nvim-autopairs
        nvim-surround
        oil
        options
        rainbow
        snacks
        treesitter
        web-devicons
        which-key
      ];

      heavy = with config.flake.modules.nvf; [
        clang
        direnv
        img-clip
        # orgmode
        python
        rust
        typst
        otter
        nix
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
              ++ heavy
              ++ [
                NixPort
              ];
          }).neovim;

        nvf-NixToks =
          (inputs.nvf.lib.neovimConfiguration {
            inherit pkgs;
            modules =
              with config.flake.modules.nvf;
              base
              ++ heavy
              ++ [
                NixToks
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
