{
  flake.modules.nixos.cache =
    { config, ... }:
    {
      # Cache
      nix.settings = {
        trusted-users = [
          "root"
          "${config.custom.meta.user}"
          "@wheel"
        ];
        substituters = [
          "https://cache.nixos.org/"
          # https://github.com/kalbasit/ncps local proxy
          # only useful when I have LAN locally connected to my homelab, and not trou a VPN
          # "https://ncps.ladas552.me"
        ];
        trusted-public-keys = [
          # "ncps.ladas552.me:zlWXi7hCZsoJ2idZXGbmy+k8p4cJK/W2a96DSMAj03s="
        ];
        extra-substituters = [
          "https://cache.garnix.io"
          "https://nix-community.cachix.org"
        ];
        extra-trusted-public-keys = [
          "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };

    };
}
