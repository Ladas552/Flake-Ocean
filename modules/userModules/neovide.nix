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
        { config, ... }:
        {
          programs.neovide = neovide-config // {
            settings.wsl = if config.custom.meta.hostname == "NixwsL" then true else false;
          };
        };
      hjem.neovide =
        { config, ... }:
        {
          rum.programs.neovide = neovide-config // {
            settings.wsl = if config.custom.meta.hostname == "NixwsL" then true else false;
          };
        };
    };
}
