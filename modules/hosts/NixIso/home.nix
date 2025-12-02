{
  flake.modules.homeManager.NixIso =
    { lib, pkgs, ... }:
    {
      # Don't change
      home.stateVersion = "25.11"; # Please read the comment before changing.
      # Standalone Packages for user
      home.packages = with pkgs; [
        libreoffice-fresh
        # shotcut
        imagemagick
        wl-clipboard
        ffmpeg
        gst_all_1.gst-libav
        libqalculate
        lshw
        pamixer
        pwvucontrol
        qbittorrent
        telegram-desktop
        xarchiver
      ];

      # Environmental Variables
      home.sessionVariables = {
        BROWSER = "chromium";
      };

      # wget install script

      home.shellAliases = {
        wget-install = "${lib.getExe' pkgs.wget "wget"} https://raw.githubusercontent.com/Ladas552/Flake-Ocean/refs/heads/master/docs/zfs.norg";
        git-install = "${lib.getExe' pkgs.git "git"} clone https://github.com/Ladas552/Flake-Ocean.git";
      };
    };
}
