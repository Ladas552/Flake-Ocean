{
  flake.modules = {
    nixos.cat-mocha =
      { pkgs, ... }:
      {
        stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      };
    homeManager.cat-mocha =
      { pkgs, ... }:
      {
        stylix = {
          targets = {
            librewolf.profileNames = [ "ladas552" ];
            bspwm.enable = false;
            kitty.enable = false;
            xfce.enable = false;
            vesktop.enable = false;
            fish.enable = false;
            neovide.enable = false;
            nixvim.enable = false;
            nvf.enable = false;
            helix.enable = false;
            emacs.enable = false;
            ghostty.enable = false;
            foot.enable = false;
            rofi.enable = false;
            tofi.enable = false;
          };
          iconTheme = {
            enable = true;
            package = pkgs.candy-icons;
            dark = "candy-icons";
            light = "candy-icons";
          };
        };
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
