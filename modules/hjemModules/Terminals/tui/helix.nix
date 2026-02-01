{
  flake.modules.hjem.helix =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      packages = with pkgs; [
        nixd
        nixfmt
        clang-tools
        ruff
        basedpyright
        tinymist
        typstyle
      ];
      rum.programs.helix = {
        enable = true;

        # options
        settings = {
          # set theme from global theme or adwaita-dark if NixMux
          theme =
            if config.custom.meta.hostname == "NixMux" then
              "adwaita-dark"
            else
              config.custom.style.colors.helix-theme;
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
              wrap-at-text-width = false;
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
                # ]
                # ++ lib.optionals (!meta.isTermux) [ "current-working-directory" ]
                # ++ [
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

          # Keymaps
          keys = {
            select = {
              "C-c" = "toggle_block_comments";
              G = "goto_last_line";
              # better manual surrouns
              m.s = "select_textobject_around";
              m.a = "surround_add";
              "$" = "goto_line_end";
            };
            insert = {
              "C-backspace" = "delete_word_backward";
              "C-w" = "delete_word_backward";
            };
            normal = {
              # comment blocks instead of line comments
              "A-c" = "toggle_block_comments";
              # Swap file pickers
              space = {
                e = "file_explorer_in_current_buffer_directory";
                E = "file_explorer";
                f = "file_picker_in_current_directory";
                F = "file_picker";
              };
              # better manual surrouns
              m.s = "select_textobject_around";
              m.a = "surround_add";
              # Muscle  Memory
              esc = [
                "collapse_selection"
                "keep_primary_selection"
              ];
              i = [
                "insert_mode"
                "collapse_selection"
              ];
              a = [
                "append_mode"
                "collapse_selection"
              ];
              G = "goto_last_line";
              # Buffer managment
              space = {
                "," = ":buffer-previous";
                "." = ":buffer-next";
                "x" = ":buffer-close";
              };
              "=" = ":format";
              K = "signature_help";
              "$" = "goto_line_end";
            };
          };
        };

        # Languages
        languages = {
          language = [
            # typst
            {
              name = "typst";
              scope = "source.typ";
              injection-regex = "typ";
              file-types = [ "typ" ];
              comment-token = "//";
              language-servers = [ "tinymist" ];
            }

            # nix
            # shout out to Zeth for adopting nixd to helix
            {
              name = "nix";
              scope = "source.nix";
              injection-regex = "nix";
              # Disables auto-save because of a bug
              # auto-format = true;
              file-types = [ "nix" ];
              comment-token = "#";
              indent = {
                tab-width = 2;
                unit = "  ";
              };
              language-servers = [ "nixd" ];
            }
          ];
          # tinymist
          language-server.tinymist = {
            command = "tinymist";
            config = {
              capabilities.hoverProvider = false;
              exportPdf = "onType";
              outputPath = "$root/$name";
              typstExtraArgs = [ "src.typ" ];
              fontPaths = [ "./fonts" ];
              formatterMode = "typstyle";
            };
          };

          # nixd
          language-server.nixd = {
            command = "nixd";
            args = [ "--inlay-hints=true" ];
            config.nixd = {
              nixpkgs.expr = "import <nixpkgs> { }";
            };
          };
        };
      };
    };
}
