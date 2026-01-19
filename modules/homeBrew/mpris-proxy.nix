{
  flake.modules.hjem.mpris-proxy-brew =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    let

      cfg = config.services.mpris-proxy;
    in
    {
      options.services.mpris-proxy = {
        enable = lib.mkEnableOption "mpris-proxy";

        package = lib.mkPackageOption pkgs "bluez" { nullable = true; };
      };
      config = lib.mkIf cfg.enable {
        systemd.services.mpris-proxy = {
          description = "Proxy forwarding Bluetooth MIDI controls via MPRIS2 to control media players";
          bindsTo = [ "bluetooth.target" ];
          after = [ "bluetooth.target" ];
          wantedBy = [ "bluetooth.target" ];
          path = [ cfg.package ];
          script = "mpris-proxy";
        };
      };
    };
}
