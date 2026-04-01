{
  flake.modules.hjem.neovide =
    { config, lib, ... }:
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
          wsl = lib.mkIf (config.custom.meta.hostname == "NixwsL") true;
        };
      };
    };
}
