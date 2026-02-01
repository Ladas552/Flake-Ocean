{
  flake.modules.nixvim.treesitter =
    { lib, config, ... }:
    {
      plugins.treesitter = {
        enable = true;
        folding.enable = true;
        nixvimInjections = true;
        grammarPackages =
          with config.plugins.treesitter.package.builtGrammars;
          [
            lua
            rust
            bash
            fish
            markdown
            markdown_inline
            nix
          ]
          ++ lib.optionals (!config.custom.meta.isTermux) [
            bibtex
            c
            cmake
            comment
            commonlisp
            cpp
            css
            csv
            diff
            dockerfile
            git_rebase
            gitcommit
            gitignore
            go
            html
            ini
            javascript
            json
            julia
            kdl
            kotlin
            luadoc
            make
            python
            rasi
            requirements
            ron
            sxhkdrc
            todotxt
            toml
            typescript
            typst
            vim
            vimdoc
            xml
            yaml
            zathurarc
          ];
        settings = {
          indent.enable = true;
          highlight.enable = true;
          incremental_selection = {
            enable = false;
            keymaps = {
              init_selection = "<C-space>";
              node_incremental = "<C-space>";
              scope_incremental = false;
              node_decremental = "<bs>";
            };
          };
        };
      };
    };
}
