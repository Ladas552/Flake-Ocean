{ self, ... }:
{
  flake.modules.homeManager.NixPort =
    { pkgs, ... }:
    let
      sources = pkgs.callPackage "${self}/_sources/generated.nix" { };
    in
    {
      home.shellAliases = {
        # I don't want to compile rocm for them
        shotcut = "nix run nixpkgs#shotcut";
        alpaca = "nix run nixpkgs#alpaca";
      };
      # Don't change
      home.stateVersion = "24.11"; # Please read the comment before changing.
      # Standalone Packages for user
      home.packages = with pkgs; [
        (pkgs.haskell.lib.dontCheck (
          pkgs.haskellPackages.callCabal2nix "nvfetcher" sources.nvfetcher.src { }
        ))
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
      # Environmental Variables
      home.sessionVariables = {
        BROWSER = "librewolf";
      };
    };
}
