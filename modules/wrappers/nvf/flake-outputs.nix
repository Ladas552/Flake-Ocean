{ config, inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      base = with config.flake.modules.nvf; [
        neorg
        plugins
        options
        autocmd
        cat-mocha
        diagnostics
        blink-cmp
      ];
    in
    {
      # my nvf config
      packages = {
        nvf-NixPort =
          (inputs.nvf.lib.neovimConfiguration {
            inherit pkgs;
            modules =
              with config.flake.modules.nvf;
              base
              ++ [
                NixPort
                lsp-config
                otter
                nix
              ];
          }).neovim;

        nvf-NixMux =
          (inputs.nvf.lib.neovimConfiguration {
            inherit pkgs;
            modules =
              with config.flake.modules.nvf;
              base
              ++ [
                NixMux
              ];
          }).neovim;
      };
    };
}
