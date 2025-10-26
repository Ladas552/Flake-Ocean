{
  flake.modules.nixos.wine =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # wine
        winePackages.stagingFull
        winetricks
      ];

    };
}
