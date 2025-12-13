{ config, inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    let
      base = with config.flake.modules.nvf; [
        neorg
        plugins
        options
        # autocmd
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
