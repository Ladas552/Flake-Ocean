{ config, ... }:
{
  flake.modules =
    let
      # define the style across all the modules
      custom.style = {
        font = {
          name = "JetBrainsMono Nerd Font Mono";
          font-family = "JetBrainsMono NFM SemiBold";
        };
      };
    in
    {
      nixos.cat-mocha =
        { pkgs, ... }:
        {
          inherit custom;
          # I wanted to add fonts based on custom.style, but I can't put pkgs args in let in
          fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
          imports = [ config.flake.modules.nixos.fonts ];
        };
      hjem.cat-mocha =
        { config, ... }:
        {
          inherit custom;
          rum.programs.helix.settings.theme = "catppuccin_macchiato";
          rum.programs.ghostty.settings = {
            theme = "dracata";
            font-size = 13;
            font-family = config.custom.style.font.font-family;
          };
        };
      homeManager.cat-mocha =
        { config, ... }:
        {
          inherit custom;
          # Other modules
          programs.helix.settings.theme = "catppuccin_macchiato";
          # Enable custom pallet
          programs.ghostty.settings = {
            theme = "dracata";
            font-size = 13;
            font-family = config.custom.style.font.font-family;
          };
        };
    };
}
# dconf.settings = lib.mkForce {
#   "org/gnome/desktop/interface" = {
#     color-scheme = "prefer-dark";
#   };
# };
