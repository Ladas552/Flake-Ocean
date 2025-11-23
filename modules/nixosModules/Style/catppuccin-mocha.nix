{ config, ... }:
{
  flake.modules = {
    nixos.cat-mocha = {
      imports = [
        config.flake.modules.nixos.fonts
      ];
    };
    hjem.cat-mocha = {
      rum.programs.helix.settings.theme = "catppuccin_macchiato";
      rum.programs.ghostty.settings = {
        theme = "dracata";
        font-size = 13;
        font-family = "JetBrainsMono NFM SemiBold";
      };
    };
    homeManager.cat-mocha = {
      # Other modules
      programs.helix.settings.theme = "catppuccin_macchiato";
      # Enable custom pallet
      programs.ghostty.settings = {
        theme = "dracata";
        font-size = 13;
        font-family = "JetBrainsMono NFM SemiBold";
      };
    };
  };
}
# dconf.settings = lib.mkForce {
#   "org/gnome/desktop/interface" = {
#     color-scheme = "prefer-dark";
#   };
# };
