{
  flake.modules.nixvim.nixd =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      plugins.lsp.servers.nixd = {
        enable = true;
        # neovim trows  an error with semantic tokens
        cmd = [
          "nixd"
          "--semantic-tokens=false"
        ];
        settings = {
          nixpkgs.expr = "import <nixpkgs> { }";
          options = {
            nixos.expr = "(builtins.getFlake ''${config.custom.meta.self}'').nixosConfigurations.NixToks.options";
            home-manager.expr = "(builtins.getFlake ''${config.custom.meta.self}'').nixosConfigurations.NixToks.options.home-manager.users.type.getSubOptions []";
            nix-on-droid.expr = "(builtins.getFlake ''${config.custom.meta.self}'').nixOnDroidConfigurations.NixMux.options";
            nixvim.expr = "(builtins.getFlake ''${config.custom.meta.self}'').packages.x86_64-linux.nixvim.options";
            nvf.expr = "(builtins.getFlake ''${config.custom.meta.self}'').packages.x86_64-linux.nvf.neovimConfig";
          };
        };
      };
      plugins.conform-nvim.settings = {
        formatters_by_ft.nix = [ "nixfmt" ];
        formatters.nixfmt.command = lib.getExe' pkgs.nixfmt "nixfmt";
      };
    };
}
