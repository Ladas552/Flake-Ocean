{
  flake.modules.homeManager.rofi =
    {
      pkgs,
      lib,
      modulesPath,
      ...
    }:
    {
      imports = [ "${modulesPath}/programs/rofi.nix" ];
      programs.rofi = {
        enable = true;
        font = "JetBrains Mono Nerd Font 11";
        # terminal = "${lib.getExe inputs.ghostty.packages.x86_64-linux.default}";
        terminal = "${lib.getExe' pkgs.ghostty "ghostty"}";
        # terminal = "foot";
        theme = ./theme.rasi;
      };

      # persist for Impermanence
      custom.imp.home.cache.files = [
        ".cache/rofi3.druncache"
        ".cache/rofi-entry-history.txt"
      ];
    };
}
