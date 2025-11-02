{
  flake.modules.hjem.neovide = {
    rum.programs.neovide = {
      enable = true;
      settings = {
        font = {
          size = 13;
          normal = "JetBrainsMono NFM SemiBold";
        };
        vsync = false;
        srgb = true;
        wsl = false;
      };
    };
  };
}
