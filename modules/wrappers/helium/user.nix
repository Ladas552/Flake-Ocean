{ self, ... }:
{
  flake.modules.hjem.helium =
    { pkgs, ... }:
    {
      packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.helium ];

      custom.imp = {
        home.directories = [ ".config/net.imput.helium" ];
        home.cache.directories = [
          ".cache/net.imput.helium"
          ".local/share/applications"
        ];
      };
    };
}
