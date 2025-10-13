{
  flake.modules.nixos.stylix =
    { inputs, pkgs, ... }:
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
            name = "JetBrainsMono NFM SemiBold";
          };
          sansSerif = {
            package = pkgs.nerd-fonts.jetbrains-mono;
            name = "JetBrainsMono NFM SemiBold";
          };
          emoji = {
            package = pkgs.noto-fonts-emoji;
            name = "Noto Color Emoji";
          };
          monospace = {
            package = pkgs.nerd-fonts.jetbrains-mono;
            name = "JetBrainsMono NFM SemiBold";
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
