{ lib, self, ... }:
# define nvf modules for homeManager and hjem
{
  flake.modules = {
    homeManager.nvf =
      { pkgs, config, ... }:
      let
        nvf-NixPort = self.packages.${pkgs.stdenv.hostPlatform.system}.nvf-NixPort;
        nvf-NixMux = self.packages.${pkgs.stdenv.hostPlatform.system}.nvf-NixMux;
      in
      {
        home.packages =
          [ ]
          ++ lib.optionals (!config.custom.meta.isTermux) [ nvf-NixPort ]
          ++ lib.optionals config.custom.meta.isTermux [ nvf-NixMux ];
        home.sessionVariables.EDITOR = "neovim";
      };
    hjem.nvf =
      { pkgs, config, ... }:
      let
        nvf-NixPort = self.packages.${pkgs.stdenv.hostPlatform.system}.nvf-NixPort;
        nvf-NixMux = self.packages.${pkgs.stdenv.hostPlatform.system}.nvf-NixMux;
      in
      {
        packages =
          [ ]
          ++ lib.optionals (!config.custom.meta.isTermux) [ nvf-NixPort ]
          ++ lib.optionals config.custom.meta.isTermux [ nvf-NixMux ];
        environment.sessionVariables.EDITOR = "neovim";
      };
  };
}
