{ config, ... }:
{
  flake.modules.nixvim.NixPort =
    let
      c = config.flake.modules.nixvim;
    in
    {
      imports = [
        # Neovim vanilla options
        c.autocmd
        c.options
        c.keymaps
        c.cat-mocha
        c.diagnostics
        # Plugins
        # Neorg module only for overlay. Don't forget to reenable overlay in flake.nix
        # c.neorg-overlay
        c.luasnip
        c.blink-cmp
        c.auto-save
        c.cord
        c.direnv
        c.img-clip
        c.neogit
        c.neorg
        c.nvim-autopairs
        c.rainbow
        c.oil
        c.orgmode
        c.otter
        c.cyrillic
        # c.parinfer-rust
        c.snacks
        c.treesitter
        c.typst-preview
        c.nix
        c.nvim-surround
        c.colorizer
        c.dashboard
        c.heirline
        c.numb
        c.web-devicons
        c.which-key
        c.basedpyright
        c.clangd
        c.conform
        c.friendly-snippets
        c.lsp-config
        # c.nil_ls
        c.nixd
        c.tinymist
        c.rustaceanvim
      ];
      enableMan = false;
      clipboard.providers.wl-copy.enable = true;
      # I want to make it copy on keybind, but `+y` doesn't work for me, so this will do
      clipboard.register = "unnamedplus";
      # package = lib.mkIf (
      #   meta.system == "x86_64-linux"
      # ) inputs.neovim-nightly-overlay.packages.x86_64-linux.default;
      withRuby = false;
      # Performance
      luaLoader.enable = true;
      performance = {
        byteCompileLua = {
          enable = true;
          configs = true;
          luaLib = true;
          initLua = true;
          plugins = true;
          nvimRuntime = true;
        };
        combinePlugins.enable = true;
      };
    };
}
