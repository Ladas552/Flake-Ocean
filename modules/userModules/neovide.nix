{
  flake.modules =
    let
      neovide-config = {
        enable = true;
        settings = {
          font = {
            size = 13;
            normal = "JetBrainsMono NFM SemiBold";
          };
          vsync = false;
          srgb = true;
        };
      };
    in
    {
      homeManager.neovide =
        { lib, config, ... }:
        {
          programs.neovide =
            neovide-config
            // lib.optionalAttrs (config.custom.meta.hostname == "NixwsL") { settings.wsl = true; };
        };
      hjem.neovide =
        { lib, config, ... }:
        {
          rum.programs.neovide =
            neovide-config
            // lib.optionalAttrs (config.custom.meta.hostname == "NixwsL") { settings.wsl = true; };
        };
    };
}
