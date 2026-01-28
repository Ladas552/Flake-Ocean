{
  flake.modules.nixvim.nvim-autopairs = {
    plugins.nvim-autopairs = {
      enable = true;
      settings = {
        check_ts = true;
      };
    };
  };
}
