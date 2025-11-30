{ config, ... }:
{
  flake.modules = {
    nixos.homeManager =
      { inputs, ... }:
      {
        imports = [ inputs.home-manager.nixosModules.home-manager ];
        home-manager = {
          useUserPackages = true;
          useGlobalPkgs = true;
          backupFileExtension = "bk";
          overwriteBackup = true;
        };
      };
    nixos.homeManager-minimal = {
      home-manager.minimal = true;
      imports = [
        {
          home-manager.users."${config.custom.meta.user}".imports = [
            config.flake.modules.homeManager.homeManager-minimal
          ];
        }
      ];
    };
    homeManager.homeManager-minimal =
      { modulesPath, ... }:
      {
        imports = [
          "${modulesPath}/programs/lf.nix"
          "${modulesPath}/programs/rofi.nix"
          "${modulesPath}/programs/swaylock.nix"
          "${modulesPath}/programs/swaylock.nix"
          "${modulesPath}/programs/obs-studio.nix"
          "${modulesPath}/programs/direnv.nix"
          "${modulesPath}/programs/zathura.nix"
          "${modulesPath}/programs/mpv.nix"
          "${modulesPath}/programs/chromium.nix"
          "${modulesPath}/programs/ncmpcpp.nix"
          "${modulesPath}/programs/rmpc.nix"
          "${modulesPath}/services/mpd.nix"
          "${modulesPath}/services/mpdris2.nix"
          "${modulesPath}/services/mpris-proxy.nix" # for mpdris2

          # I hate all of this
          "${modulesPath}/programs/git.nix"
          "${modulesPath}/programs/delta.nix" # git dependency, idk
          "${modulesPath}/programs/jujutsu.nix" # delta dependency, idk
          "${modulesPath}/programs/diff-highlight.nix" # git dependency, idk
          "${modulesPath}/programs/diff-so-fancy.nix" # git dependency, idk
          "${modulesPath}/programs/difftastic.nix" # git dependency, idk
          "${modulesPath}/programs/patdiff.nix" # git dependency, idk
          "${modulesPath}/programs/riff.nix" # git dependency, idk
          "${modulesPath}/programs/gpg.nix" # git dependency, idk

          "${modulesPath}/services/syncthing.nix"
          "${modulesPath}/services/mako.nix"
          "${modulesPath}/programs/ssh.nix"
          "${modulesPath}/programs/helix.nix"
          "${modulesPath}/programs/imv.nix"
          "${modulesPath}/services/wpaperd.nix"
          "${modulesPath}/programs/fish.nix"
          "${modulesPath}/programs/gh.nix"
          "${modulesPath}/programs/home-manager.nix"
          "${modulesPath}/programs/man.nix"
          "${modulesPath}/programs/yt-dlp.nix"
          "${modulesPath}/programs/vim.nix"
          "${modulesPath}/programs/thunderbird.nix"
          "${modulesPath}/programs/fastfetch.nix"
          "${modulesPath}/programs/ghostty.nix"
          "${modulesPath}/services/arrpc.nix"
          "${modulesPath}/programs/vesktop.nix"
          "${modulesPath}/services/mpd-discord-rpc.nix"
          "${modulesPath}/programs/bat.nix"
          "${modulesPath}/programs/btop.nix"
          "${modulesPath}/programs/eza.nix"
          "${modulesPath}/programs/fd.nix"
          "${modulesPath}/programs/fzf.nix"
          "${modulesPath}/programs/ripgrep.nix"
          "${modulesPath}/programs/zoxide.nix"
          "${modulesPath}/programs/foot.nix"
        ];
      };
  };
}
