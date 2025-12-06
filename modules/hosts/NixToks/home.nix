{
  flake.modules.homeManager.NixToks =
    { pkgs, lib,config, ... }:
    {
      home.shellAliases = {
        en = lib.mkForce "hx ${config.custom.meta.self}";
        eh = lib.mkForce "hx ${config.custom.meta.self}";
      };
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
        lazygit

      ];

    };
}
