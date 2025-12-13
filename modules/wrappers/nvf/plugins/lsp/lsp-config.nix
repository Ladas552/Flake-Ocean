{
  flake.modules.nvf.lsp-config.vim = {
    languages = {
      enableFormat = true;
      enableTreesitter = true;
    };
    lsp = {
      enable = true;
      formatOnSave = true;
      inlayHints.enable = true;
      lspconfig.enable = true;
      lspkind.enable = true;
      mappings = {
        goToDefinition = "<leader>LD";
        renameSymbol = "<F2>";
        codeAction = "<leader>lc";
        listImplementations = "<leader>lD";
        hover = "K";
        nextDiagnostic = "<leader>[";
        previousDiagnostic = "<leader>]";
      };
    };
  };
}
