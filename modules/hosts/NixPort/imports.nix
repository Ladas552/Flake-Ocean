{ config, ... }:
let
  custom.meta = {
    hostname = "NixPort";
    self = "/persist/home/${config.custom.meta.user}/Projects/my_repos/Flake-Ocean";
    isTermux = false;
    norg = "~/Documents/Norg";
  };
in
{
  flake.modules.nixvim.NixPort.imports = [ { inherit custom; } ];
  flake.modules.nixos."hosts/NixPort" = {
    imports =
      with config.flake.modules.nixos;
      [
        { inherit custom; }
        NixPort
        # Modules
        ## Games
        games
        emulators
        bluetooth
        cache
        cat-mocha
        cups
        firewall
        general
        imp
        kdeconnect
        nh
        niri-flake
        nuphy
        nix
        openssh
        otd
        pipewire
        plymouth
        sops
        adb
        systemd-boot
        tailscale
        thunar
        tlp
        noct
        xkb
        zfs
        network-manager
        # Users
        root
        ladas552
      ]
      # Specific Home-Manager modules
      ++ [
        {
          home-manager.users."${config.custom.meta.user}".imports = with config.flake.modules.homeManager; [
            { inherit custom; }
            NixPort
            cat-mocha
            chromium
            direnv
            emacs
            fastfetch
            fish
            gh
            lf
            manual
            mpd
            shell
            syncthing
            thunderbird
            vesktop
            yt-dlp
            git
            zathura
            zfs
            openssh
            bluetooth
            niri-flake
            noct
          ];
        }
      ]
      ++ [
        {
          hjem.users."${config.custom.meta.user}".imports = with config.flake.modules.hjem; [
            { inherit custom; }
            # fish
            # direnv
            obs
            # git
            neovide
            ghostty
            cat-mocha
            # imv
            chawan
            nixvim
            mpv
            # flameshot
          ];
        }
      ];
  };
}
