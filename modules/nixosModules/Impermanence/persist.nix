# This file exists to not clutter other nixos module files with generic persists, like network manager. I will move all options below somewhere else before I finish impermanence setup
{
  flake.modules.nixos.imp = {
    custom.imp = {
      root = {
        directories = [
          "/etc/NetworkManager/"
          "/var/lib/NetworkManager"
          "/var/lib/iwd"
        ];
      };
      home = {
        directories = [
          ".librewolf"
        ];
        cache = {
          directories = [
            ".local/share/Trash"
            ".local/share/qalculate"
            ".local/share/TelegramDesktop"
            ".local/share/nvim"
            ".local/state/nvim"
            ".local/state/nvf"
            ".config/libreoffice"
            ".cache/librewolf"
            ".cache/keepassxc"
            ".config/keepassxc"
            ".config/qBittorrent"
            ".local/share/qBittorrent"
            ".cache/nix"
            ".cache/nix-index"
          ];
        };
      };
    };
  };
}
