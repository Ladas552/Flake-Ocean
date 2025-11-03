{ self, ... }:
{
  flake.modules.homeManager.NixToks =
    { pkgs, lib, ... }:
    let
      nixvim = self.packages.${pkgs.stdenv.hostPlatform.system}.nixvim;
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

    };
}
