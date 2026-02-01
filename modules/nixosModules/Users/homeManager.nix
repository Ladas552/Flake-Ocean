{ inputs, ... }:
{
  flake.modules = {
    nixos.homeManager = {
      imports = [ inputs.home-manager.nixosModules.home-manager ];
      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        backupFileExtension = "bk";
        overwriteBackup = true;
        minimal = true;
      };
    };
    # I hate nix-on-droid for this, but I am too lazy to add the option into it so I probably should hate myself
    homeManager.homeManager-minimal =
      { modulesPath, ... }:
      {
        imports = [
          "${modulesPath}/programs/lf.nix"
          "${modulesPath}/programs/direnv.nix"
          "${modulesPath}/programs/zathura.nix"
          "${modulesPath}/programs/mpv.nix"
          "${modulesPath}/programs/rmpc.nix"
          "${modulesPath}/services/mpd.nix"
          "${modulesPath}/services/mpdris2.nix"
          "${modulesPath}/services/mpris-proxy.nix" # for mpdris2
          "${modulesPath}/programs/vim.nix"

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
          "${modulesPath}/programs/ssh.nix"
          "${modulesPath}/programs/fish.nix"
          "${modulesPath}/programs/gh.nix"
          "${modulesPath}/programs/home-manager.nix"
          "${modulesPath}/programs/man.nix"
          "${modulesPath}/programs/yt-dlp.nix"
          "${modulesPath}/programs/thunderbird.nix"
          "${modulesPath}/programs/fastfetch.nix"
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
        ];
      };
  };
}
