{
  flake.modules.nixos.adb =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.android-tools ];
    };
}
