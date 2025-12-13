{
  flake.modules.nvf.cat-mocha = {
    vim = {
      theme = {
        enable = true;
        name = "catppuccin";
        style = "macchiato";
      };
      highlight."hl-CursorLine" = {
        fg = "NONE";
        bg = "NONE";
      };
    };
  };
}
