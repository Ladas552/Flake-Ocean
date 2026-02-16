{ lib, self, ... }:
# define nvf modules for homeManager and hjem
{
  flake.modules = {
    # I only use this home-manager in Nix-On-Droid, so no logic in making this one modular
    homeManager.nvf =
      let
        nvf-NixMux = self.packages."aarch64-linux".nvf-NixMux;
      in
      {
        home.packages = [ nvf-NixMux ];
        home.sessionVariables.EDITOR = "neovim";
      };
    hjem.nvf =
      { config, ... }:
      let
        nvf-NixPort = self.packages."x86_64-linux".nvf-NixPort;
        nvf-NixToks = self.packages."x86_64-linux".nvf-NixToks;
        nvf-NixWool = self.packages."aarch64-linux".nvf-NixWool;
      in
      {
        packages =
          [ ]
          ++ lib.optionals (config.custom.meta.hostname == "NixPort") [ nvf-NixPort ]
          ++ lib.optionals (config.custom.meta.hostname == "NixToks") [ nvf-NixToks ]
          ++ lib.optionals (config.custom.meta.hostname == "NixWool") [ nvf-NixWool ];
        environment.sessionVariables.EDITOR = "neovim";
      };
  };
}
