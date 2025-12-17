{ self, ... }:
{
  flake.modules.nvf.neorg =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    let
      # nvfetcher pins
      sources = pkgs.callPackage "${self}/_sources/generated.nix" { };
      # Neorg Plugins
      lib-neorg_query = pkgs.rustPlatform.buildRustPackage {
        src = sources.neorg-query.src;
        name = "neorg_query";
        # change this to cargoLock somehow
        cargoHash = "sha256-m/QhtE6e2wmTRBQ8xrWfgsmvDaaR1s9z/BLoFgFz/Do=";
        nativeBuildInputs = [ pkgs.gitMinimal ];
      };
      neorg-query = pkgs.vimUtils.buildVimPlugin {
        name = "neorg-query";
        src = sources.neorg-query.src;
        preInstall =
          let
            ext = pkgs.stdenv.hostPlatform.extensions.sharedLibrary;
          in
          ''
            mkdir -p $out/lua/neorg_query
            ln -s ${lib-neorg_query}/lib/libneorg_query${ext} $out/lua/
          '';
        nvimSkipModules = [
          # skip checks
          "neorg.modules.external.query.module"
          "neorg_query.formatter"
          "neorg_query.api"
        ];
      };
      neorg-interim-ls = pkgs.vimUtils.buildVimPlugin {
        name = "neorg-interim-ls";
        src = sources.neorg-interim-ls.src;
        nvimSkipModules = [
          # skip checks
          "neorg.modules.external.lsp-completion.module"
          "neorg.modules.external.interim-ls.module"
          "neorg.modules.external.refactor.module"
        ];
      };
      neorg-conceal-wrap = pkgs.vimUtils.buildVimPlugin {
        name = "neorg-conceal-wrap";
        src = sources.neorg-conceal-wrap.src;
        nvimSkipModules = [
          # skip checks
          "neorg.modules.external.conceal-wrap.module"
        ];
      };
    in
    {
      vim = {
        extraPlugins = {
          "neorg-interim-ls".package = neorg-interim-ls;
          "neorg-conceal-wrap".package = neorg-conceal-wrap;
        }
        // lib.optionalAttrs (!config.custom.meta.isTermux) {
          "neorg_query".package = neorg-query;
        };
        notes.neorg = {
          enable = true;
          treesitter.enable = true;
          setupOpts.load = {
            # Extra modules
            "external.query" = lib.mkIf (!config.custom.meta.isTermux) {
              config = {
                index_on_launch = true;
                update_on_change = true;
              };
            };
            "external.interim-ls".config.completion_provider.categories = true;
            # Core
            "core.defaults".enable = true;
            "core.concealer".config.icon_preset = "diamond";
            "core.esupports.metagen" = lib.mkIf (lib.isString config.custom.meta.norg) {
              config = {
                timezone = "implicit-local";
                type = "empty";
                undojoin_updates = false;
              };
            };
            "core.tangle".config = {
              report_on_empty = true;
              tangle_on_write = false;
            };
            "core.completion".config.engine.module_name = "external.lsp-completion";
            "core.keybinds" = lib.mkIf (lib.isString config.custom.meta.norg) {
              config = {
                default_keybinds = true;
                neorg_leader = "<Leader><Leader>";
              };
            };
            "core.journal" = lib.mkIf (lib.isString config.custom.meta.norg) {
              config = {
                workspace = "journal";
                journal_folder = "/./";
              };
            };
            "core.dirman" = lib.mkIf (lib.isString config.custom.meta.norg) {
              config = {
                workspaces = {
                  general = "${config.custom.meta.norg}";
                  life = "${config.custom.meta.norg}/Life";
                  work = "${config.custom.meta.norg}/Study";
                  journal = "${config.custom.meta.norg}/Journal";
                  archive = "${config.custom.meta.norg}/Archive";
                };
                default_workspace = "general";
              };
            };
            "core.summary" = lib.mkIf (lib.isString config.custom.meta.norg) { };
          };
        };
        globals.maploalleader = "  ";
        options = {
          foldlevel = 99;
          conceallevel = 2;
        };
        keymaps = [
          #Neorg Journal
          {
            action = "<cmd>Neorg journal today<CR>";
            key = "<leader>j";
            mode = "n";
            desc = "Journal today";
          }
        ];
      };
    };
}
