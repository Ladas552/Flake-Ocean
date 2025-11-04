{
  flake.modules.hjem.fzf =
    { config, ... }:
    {
      rum.programs.fzf = {
        enable = true;
        # doesn't seem to work anyways
        integrations.fish.enable = config.rum.programs.fish.enable;
      };
    };
}
