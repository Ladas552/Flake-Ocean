{ self, ... }:
{
  flake.modules =
    let
      # define the style across all the modules
      custom.style = {
        font = {
          name = "JetBrainsMono Nerd Font Mono";
          font-family = "JetBrainsMono NFM";
        };
        colors = {
          helix-theme = "catppuccin_macchiato";
          palette = {
          };
        };
        gtk.cursor = {
          name = "BreezeX-RosePine-Linux";
          size = 28;
        };
      };
    in
    {
      nixos.cat-mocha =
        { pkgs, config, ... }:
        {
          inherit custom;
          # I wanted to add fonts based on custom.style, but I can't put pkgs args in let in
          fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
          imports = [ self.modules.nixos.fonts ];
          # Thanks @Gerg
          programs.dconf.profiles.user.databases = [
            {
              lockAll = false;
              settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
            }
          ];
          # cursor
          environment = {
            sessionVariables = {
              XCURSOR_SIZE = config.custom.style.gtk.cursor.size;
              XCURSOR_THEME = config.custom.style.gtk.cursor.name;
            };

            systemPackages = [
              pkgs.rose-pine-cursor
            ];
          };
        };
      hjem.cat-mocha =
        { config, pkgs, ... }:
        {
          inherit custom;

          # Add cursor icon link to $XDG_DATA_HOME/icons as well for redundancy.
          # stolen from Poz
          # xdg.data.files."icons/default/index.theme".source =
          xdg.data.files."icons/${config.custom.style.gtk.cursor.name}".source =
            "${pkgs.rose-pine-cursor}/share/icons/${config.custom.style.gtk.cursor.name}";

          xdg.config.files."X11/xresources".text = ''
            Xcursor.theme = ${config.custom.style.gtk.cursor.name}
            Xcursor.size = ${toString config.custom.style.gtk.cursor.size}
          '';

          rum.programs = {
            ghostty.settings = {
              theme = "dracata";
              font-size = 13;
              font-family = config.custom.style.font.font-family;
            };
            kitty.settings = {
              font_family = config.custom.style.font.font-family;
              font_size = 13;
            };
            neovide.settings.font = {
              size = 13;
              normal = config.custom.style.font.name;
            };
          };
        };
    };
}
