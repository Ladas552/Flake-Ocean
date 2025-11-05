{
  flake.modules.homeManager.helix =
    { pkgs, ... }:
    {
      programs.helix = {
        extraPackages = [
          pkgs.ruff
          pkgs.basedpyright
        ];
      };
    };
}
