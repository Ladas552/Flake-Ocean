{ self, ... }:
{
  flake.modules.homeManager.NixPort =
    { pkgs, ... }:
    let
      nixvim = self.packages.${pkgs.system}.nixvim;
    in
    {
      # Me
      home.username = "ladas552";
      home.homeDirectory = "/home/ladas552";
      # Don't change
      home.stateVersion = "24.11"; # Please read the comment before changing.
      # Standalone Packages for user
      home.packages = with pkgs; [
        nixvim
        blender
        libreoffice-fresh
        # shotcut
        imagemagick
        wl-clipboard
        ffmpeg
        gst_all_1.gst-libav
        librewolf
        hunspell
        hunspellDicts.en-us-large
        hunspellDicts.ru-ru
        keepassxc
        libqalculate
        lshw
        pamixer
        pwvucontrol
        qbittorrent
        telegram-desktop
        typst
        xarchiver
        zotero
      ];

      # Environment and Dependencies
      xdg = {
        enable = true;
      };

      # Environmental Variables
      home.sessionVariables = {
        BROWSER = "librewolf";
      };

      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;

      programs.man.enable = false;
    };
}
