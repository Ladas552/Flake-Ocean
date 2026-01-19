{
  flake.modules.hjem.mpd-brew =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    let
      inherit (lib.modules) mkIf;
      inherit (lib.options) mkEnableOption mkPackageOption;

      cfg = config.services.mpd;
    in
    {
      options.services.mpd = {
        enable = mkEnableOption "mpd";

        package = mkPackageOption pkgs "mpd" { nullable = true; };
      };
      config = mkIf cfg.enable {
      };
    };
}
