{
  flake.modules.homeManager.lf-ctpv =
    { lib, pkgs, ... }:
    {
      programs.lf = {
        previewer.source = "${lib.meta.getExe' pkgs.ctpv "ctpv"}";

        extraConfig = # bash
          ''
            &${lib.meta.getExe' pkgs.ctpv "ctpv"} -s $id
            cmd on-quit %${lib.meta.getExe' pkgs.ctpv "ctpv"} -e $id
            set cleaner ${lib.meta.getExe' pkgs.ctpv "ctpvclear"}
          '';
      };
    };
}
