{ self, ... }:
{
  flake.modules.hjem.helium =
    { pkgs, ... }:
    {
      packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.helium ];

      custom.imp.home.cache.directories = [
        ".cache/net.imput.helium"
        ".config/net.imput.helium"
        ".local/share/applications" # bubblewrap doesn't work without this
      ];
    };
}
