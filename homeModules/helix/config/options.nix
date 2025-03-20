{ meta, ... }:

{
  programs.helix.settings = {
    theme = if meta.isTermux then "adwaita-dark" else "catppuccin_macchiato";
    editor = {
      # LSP
      lsp = {
        display-inlay-hints = true;
        # to remove useless text
        auto-signature-help = false;
        display-signature-help-docs = false;
        display-progress-messages = true;
      };
      inline-diagnostics = {
        cursor-line = "warning";
      };
      # UI
      line-number = "relative";
      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "block";
      };
      gutters.layout = [
        "line-numbers"
        "spacer"
        "diagnostics"
      ];
      indent-guides = {
        render = true;
        character = "·";
        skip-levels = 2;
      };
      soft-wrap = {
        enable = true;
        wrap-indicator = "";
        wrap-at-text-width = true;
      };
      statusline = {
        left = [
          "mode"
          "file-base-name"
          "read-only-indicator"
          "file-modification-indicator"
        ];
        right = [
          "diagnostics"
          "register"
          "position"
          "total-line-numbers"
          "file-encoding"
          "spinner"
        ];
      };
      true-color = true;
      undercurl = true;
      bufferline = "multiple";
      popup-border = "menu";
      # Workflow
      auto-save.after-delay = {
        enable = true;
        timeout = 1000;
      };
      file-picker = {
        hidden = false;
      };
      continue-comments = false;
      trim-trailing-whitespace = true;
      trim-final-newlines = true;
    };
  };
}
