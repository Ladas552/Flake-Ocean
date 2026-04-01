{ lib, self, ... }:
# define nvf modules for systems so that they don't collide their inherited options
{
  flake.modules = {
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
