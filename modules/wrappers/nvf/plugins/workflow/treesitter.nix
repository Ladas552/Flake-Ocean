{
  flake.modules.nvf.treesitter =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      vim.treesitter = {
        enable = true;
        fold = true;
        grammars =
          with pkgs.vimPlugins.nvim-treesitter.builtGrammars;
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
            # jsonc
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
      };
    };
}
