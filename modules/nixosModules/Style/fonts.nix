{
  flake.modules.nixos.fonts =
    { pkgs, config, ... }:
    {
      # stolen from saygo
      fonts = {
        fontconfig = {
          enable = true;
          defaultFonts = {
            serif = [ config.custom.style.font.name ];
            sansSerif = [ config.custom.style.font.name ];
            monospace = [ config.custom.style.font.name ];
          };
          antialias = true;
          hinting = {
            enable = true;
            style = "full";
            autohint = false;
          };
          subpixel = {
            rgba = "none";
            lcdfilter = "default";
          };
        };
      };
      fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        # Enable nerd fonts for every font
        #(lib.filter lib.isDerivation (lib.attrValues pkgs.nerd-fonts))
      ];
    };
}
