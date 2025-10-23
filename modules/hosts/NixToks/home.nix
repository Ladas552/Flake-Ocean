{ self, ... }:
{
  flake.modules.homeManager.NixToks =
    { pkgs, lib, ... }:
    let
      nixvim = self.packages.${pkgs.system}.nixvim;
    in

    {
      # Don't change
      home.stateVersion = "24.11"; # Please read the comment before changing.
      # Standalone Packages for user
      home.packages = with pkgs; [
        nixvim
        imagemagick
        ffmpeg
        gst_all_1.gst-libav
        libqalculate
        lshw
        nuspell
        python3
        qbittorrent
        typst
        # custom.Subtitlenator

      ];

      home.shellAliases = {
        eh = lib.mkForce "nvim -c 'cd /home/ladas552/Nix-Is-Unbreakable' /home/ladas552/Nix-Is-Unbreakable/flake.nix";
        yy = lib.mkForce "nh os switch /home/ladas552/Nix-Is-Unbreakable";
        yyy = lib.mkForce "nh os switch -u /home/ladas552/Nix-Is-Unbreakable";
      };
    };
}
