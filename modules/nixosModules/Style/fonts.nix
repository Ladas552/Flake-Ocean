{
  flake.modules.nixos.fonts =
    { pkgs, ... }:
    let
      font = "JetBrainsMono Nerd Font Mono";
    in
    {
      # stolen from saygo
      fonts = {
        fontconfig = {
          enable = true;
          defaultFonts = {
            serif = [ font ];
            sansSerif = [ font ];
            monospace = [ font ];
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
        nerd-fonts.jetbrains-mono
        # Enable nerd fonts for every font
        #(lib.filter lib.isDerivation (lib.attrValues pkgs.nerd-fonts))
      ];
    };
}
