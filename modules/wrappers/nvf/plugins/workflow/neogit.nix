{
  flake.modules.nvf.neogit.vim = {
    git.neogit.enable = true;
    keymaps = [
      # NeoGit
      {
        action = "<cmd>Neogit<CR>";
        key = "<leader>g";
        mode = "n";
        desc = "Open neogit";
      }
    ];
  };
}
