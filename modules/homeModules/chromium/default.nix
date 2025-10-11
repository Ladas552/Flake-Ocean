{
  flake.modules.homeManager.chromium =
    { pkgs, ... }:
    {
      programs.chromium = {
        enable = true;
        commandLineArgs = [ "--no-default-browser-check" ];
        package = pkgs.ungoogled-chromium;
        dictionaries = [ pkgs.hunspellDictsChromium.en_US ];
      };

      # persist for Impermanence
      customhm.imp.home.cache.directories = [
        ".cache/chromium"
        ".config/chromium"
      ];
    };
}
