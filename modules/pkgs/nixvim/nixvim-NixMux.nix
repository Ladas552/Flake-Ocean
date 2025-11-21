{ config, ... }:
{
  flake.modules.nixvim.NixMux =
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
        c.neorg
        c.luasnip
        c.blink-cmp
        c.auto-save
        c.cyrillic
        c.img-clip
        c.neogit
        c.nvim-autopairs
        c.oil
        c.snacks
        c.treesitter
        c.colorizer
        c.dashboard
        c.heirline
        c.numb
        c.web-devicons
        c.which-key
        c.friendly-snippets
      ];
      enableMan = false;
      withRuby = false;
      withPython3 = false;
      # Performance
      luaLoader.enable = true;
      performance = {
        byteCompileLua = {
          enable = true;
          nvimRuntime = true;
          plugins = true;
        };
        combinePlugins.enable = true;
      };
    };
}
