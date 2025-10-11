{ pkgs, ... }:

{
  flakes.modules.HM.helix = {
    programs.helix = {
      extraPackages = [
        pkgs.ruff
        pkgs.basedpyright
      ];
    };
  };
}
