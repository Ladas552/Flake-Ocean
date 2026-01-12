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
        colors = {
          helix-theme = "catppuccin_macchiato";
          palette = {
          };
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
          rum.programs.ghostty.settings = {
            theme = "dracata";
            font-size = 13;
            font-family = config.custom.style.font.font-family;
          };
        };
      homeManager.cat-mocha =
        { pkgs, ... }:
        {
          inherit custom;

          home.pointerCursor = {
            package = pkgs.rose-pine-cursor;
            name = "BreezeX-RosePine-Linux";
            size = 28;
            gtk.enable = true;
            x11.enable = true;
          };
          gtk = {
            enable = true;
            theme = {
              name = "adw-gtk3";
              package = pkgs.adw-gtk3;
            };
            iconTheme = {
              name = "candy-icons";
              package = pkgs.candy-icons;
            };
          };
          dconf.settings = {
            "org/gnome/desktop/interface" = {
              color-scheme = "prefer-dark";
            };
          };
        };
    };
}
