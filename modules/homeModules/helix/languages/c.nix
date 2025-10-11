{ pkgs, ... }:

{
  flakes.modules.HM.helix = {
    programs.helix = {
      extraPackages = [ pkgs.clang-tools ];
    };
  };
}
