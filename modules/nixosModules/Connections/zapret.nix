# because fuck my country ig
{
  flake.modules.nixos.zapret = {
    services.zapret = {
      enable = true;
      whitelist = [
        "protonvpn.com"
        "wireguard.com"
        "mullvad.net"
        "matrix.org"
      ];
      params = [
        "--dpi-desync=multidisorder"
        "--dpi-desync-split-pos=1"
      ];
    };
  };
}
