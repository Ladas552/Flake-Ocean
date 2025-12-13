{
  flake.modules.nvf.nix =
    {
      lib,
      # config,
      pkgs,
      ...
    }:
    {
      vim = {
        languages.nix = {
          enable = true;
          format.type = [ "nixfmt" ];
          lsp.servers = [ "nixd" ];
          treesitter.enable = true;
        };
        lsp.servers."nixd" = {
          # neovim trows  an error with semantic tokens
          cmd = lib.mkForce [
            "${lib.getExe' pkgs.nixd "nixd"}"
            "--semantic-tokens=false"
          ];
          settings.nixpkgs.expr = "import <nixpkgs> { }";
          # Completions don't work anyways because flake parts makes config funky

          # init_options = {
          #   nixos.expr = "(builtins.getFlake ''${config.custom.meta.self}'').nixosConfigurations.NixPort.options";
          #   home-manager.expr = "(builtins.getFlake ''${config.custom.meta.self}'').nixosConfigurations.NixPort.options.home-manager.users.type.getSubOptions []";
          #   nix-on-droid.expr = "(builtins.getFlake ''${config.custom.meta.self}'').nixOnDroidConfigurations.NixMux.options";
          #   nixvim.expr = "(builtins.getFlake ''${config.custom.meta.self}'').packages.x86_64-linux.nixvim.options";
          #   nvf.expr = "(builtins.getFlake ''${config.custom.meta.self}'').packages.x86_64-linux.nvf.neovimConfig";
          # };
        };
      };
    };
}
