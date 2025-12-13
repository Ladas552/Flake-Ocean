{ self, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages = {
        default = pkgs.writeShellScriptBin "hello" ''echo "Hello World"'';
        restore = pkgs.callPackage ./restore.nix { };
        gcp = pkgs.callPackage ./addcommitpush.nix { };
        rofi-wifi = pkgs.callPackage ./rofi-wifi.nix { };
        word-lookup = pkgs.callPackage ./word-lookup.nix { };
        Subtitlenator = pkgs.callPackage ./Subtitlenator.nix { };
        musnow = pkgs.callPackage ./musnow.nix { };
        wpick = pkgs.callPackage ./wpick.nix { };
        rofi-powermenu = pkgs.callPackage ./rofi-powermenu.nix { inherit self; };
      };
    };
}
