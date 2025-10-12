{
  flake.modules.nixos.games =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # Launchers
        bottles
        # heroic
        # prismlauncher
        # PC games
        osu-lazer-bin
        # arx-libertatis
        # stepmania
        openmw
        daggerfall-unity
        # luanti
        # mindustry
        steam-run
      ];
      # persist games
      custom.imp.home = {
        directories = [
          "Games"
          ".config/arx"
          ".config/openmw"
          ".config/unity3d"
          ".local/share/Mindustry"
          ".local/share/PrismLauncher"
          ".local/share/arx"
          ".local/share/bottles"
          ".local/share/openmw"
          ".local/share/osu"
        ];
      };
    };
}
