{
  flake.modules.homeManager.chromium =
    { pkgs, modulesPath, ... }:
    {
      imports = [ "${modulesPath}/programs/chromium.nix" ];
      programs.chromium = {
        enable = true;
        commandLineArgs = [ "--no-default-browser-check" ];
        package = pkgs.ungoogled-chromium;
        dictionaries = [ pkgs.hunspellDictsChromium.en_US ];
      };

      # persist for Impermanence
      custom.imp.home.cache.directories = [
        ".cache/chromium"
        ".config/chromium"
      ];
    };
}
