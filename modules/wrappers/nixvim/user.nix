{
  lib,
  self,
  ...
}:
# define nixvim modules for homeManager and hjem
{
  flake.modules = {
    homeManager.nixvim =
      {
        pkgs,
        config,
        ...
      }:
      let
        nixvim-NixPort = self.packages.${pkgs.stdenv.hostPlatform.system}.nixvim-NixPort;
        nixvim-NixMux = self.packages.${pkgs.stdenv.hostPlatform.system}.nixvim-NixMux;
      in
      {
        home.packages =
          [ ]
          ++ lib.optionals (!config.custom.meta.isTermux) [ nixvim-NixPort ]
          ++ lib.optionals config.custom.meta.isTermux [ nixvim-NixMux ];
        home.sessionVariables.EDITOR = "neovim";
      };
    hjem.nixvim =
      {
        pkgs,
        config,
        ...
      }:
      let
        nixvim-NixPort = self.packages.${pkgs.stdenv.hostPlatform.system}.nixvim-NixPort;
        nixvim-NixMux = self.packages.${pkgs.stdenv.hostPlatform.system}.nixvim-NixMux;
      in
      {
        packages =
          [ ]
          ++ lib.optionals (!config.custom.meta.isTermux) [ nixvim-NixPort ]
          ++ lib.optionals config.custom.meta.isTermux [ nixvim-NixMux ];
        environment.sessionVariables.EDITOR = "neovim";
      };
  };
}
