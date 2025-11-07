{
  flake.modules.hjem.neovide =
    { config, ... }:
    {
      rum.programs.neovide = {
        enable = true;
        settings = {
          font = {
            size = 13;
            normal = "JetBrainsMono NFM SemiBold";
          };
          vsync = false;
          srgb = true;
          wsl = if config.custom.meta.host == "NixwsL" then true else false;
        };
      };
    };
}
