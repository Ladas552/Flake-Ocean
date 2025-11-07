{
  flake.modules.nixos.stylix =
    { inputs, pkgs, ... }:
    let
      font = "JetBrainsMono NFM SemiBold";
    in
    {
      imports = [
        inputs.stylix.nixosModules.stylix
      ];

      stylix = {
        enable = true;
        image = ./wallpapers/Sacrifice.jpg;
        autoEnable = true;

        fonts = {
          serif = {
            package = pkgs.nerd-fonts.jetbrains-mono;
            name = font;
          };
          sansSerif = {
            package = pkgs.nerd-fonts.jetbrains-mono;
            name = font;
          };
          emoji = {
            package = pkgs.noto-fonts-color-emoji;
            name = "Noto Color Emoji";
          };
          monospace = {
            package = pkgs.nerd-fonts.jetbrains-mono;
            name = font;
          };
          sizes = {
            terminal = 11;
            popups = 14;
          };
        };
        cursor = {
          name = "BreezeX-RosePine-Linux";
          size = 28;
          package = pkgs.rose-pine-cursor;
        };
      };
    };
}
