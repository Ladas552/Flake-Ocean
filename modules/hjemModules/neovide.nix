{
  flake.modules.hjem.neovide =
    { config, lib, ... }:
    {
      rum.programs.neovide = {
        enable = true;
        settings = {
          vsync = false;
          srgb = true;
          wsl = lib.mkIf (config.custom.meta.hostname == "NixwsL") true;
        };
      };
    };
}
