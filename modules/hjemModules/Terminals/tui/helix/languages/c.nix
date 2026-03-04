{
  flake.modules.hjem.helix-clang =
    { pkgs, ... }:
    {
      packages = [ pkgs.clang-tools ];
    };
}
