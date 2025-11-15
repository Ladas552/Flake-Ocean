{
  flake.modules.nixos.cache = {
    # Cache
    nix.settings = {
      trusted-users = [
        "root"
        "ladas552"
        "@wheel"
      ];
      substituters = [
        "https://cache.nixos.org/"
        # https://github.com/kalbasit/ncps local proxy
        # only useful when I have LAN locally connected to my homelab, and not trou a VPN
        # "http://10.144.32.1:8501"
      ];
      trusted-public-keys = [
        # "10.144.32.1:zlWXi7hCZsoJ2idZXGbmy+k8p4cJK/W2a96DSMAj03s="
      ];
      extra-substituters = [
        "https://cache.garnix.io"
        "https://niri.cachix.org"
        "https://nix-community.cachix.org"
      ];
      extra-trusted-public-keys = [
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

  };
}
