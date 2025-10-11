{
  flake.modules.homeManager.helix =
    { pkgs, ... }:
    {
      programs.helix = {
        extraPackages = [ pkgs.clang-tools ];
      };
    };
}
