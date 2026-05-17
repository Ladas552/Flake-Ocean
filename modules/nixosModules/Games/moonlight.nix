{
  flake.modules.nixos.moonlight =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.moonlight-qt ];
    };
}
