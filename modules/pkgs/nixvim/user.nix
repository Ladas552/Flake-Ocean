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
        nixvim = self.packages.${pkgs.stdenv.hostPlatform.system}.nixvim;
        nixvim-minimal = self.packages.${pkgs.stdenv.hostPlatform.system}.nixvim-minimal;
      in
      {
        home.packages =
          [ ]
          ++ lib.optionals (!config.custom.meta.isTermux) [ nixvim ]
          ++ lib.optionals config.custom.meta.isTermux [ nixvim-minimal ];
        home.sessionVariables.EDITOR = "neovim";
      };
    hjem.nixvim =
      {
        pkgs,
        config,
        ...
      }:
      let
        nixvim = self.packages.${pkgs.stdenv.hostPlatform.system}.nixvim;
        nixvim-minimal = self.packages.${pkgs.stdenv.hostPlatform.system}.nixvim-minimal;
      in
      {
        packages =
          [ ]
          ++ lib.optionals (!config.custom.meta.isTermux) [ nixvim ]
          ++ lib.optionals config.custom.meta.isTermux [ nixvim-minimal ];
        environment.sessionVariables.EDITOR = "neovim";
      };
  };
}
