{
  flake.modules.homeManager.NixToks =
    { pkgs, ... }:

    {
      # Don't change
      home.stateVersion = "24.11"; # Please read the comment before changing.
      # Standalone Packages for user
      home.packages = with pkgs; [
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
