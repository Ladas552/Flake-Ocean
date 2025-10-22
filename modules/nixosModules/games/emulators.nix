{
  flake.modules.nixos.emulators =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        raze
        vkquake
        # Emulators
        blastem
        mgba
        snes9x-gtk
        punes
        melonDS
        # doesn't work       retroarchFull
        # too complex and need a special controller      mame
      ];
      # persist emulators
      custom.imp.home = {
        directories = [
          "Games"
          "id1"
          ".vkquake"
          ".snes9x"
          ".config/mgba"
          ".config/puNES"
          ".config/raze"
          ".local/share/blastem"
          ".local/share/puNES"
        ];
      };
    };
}
