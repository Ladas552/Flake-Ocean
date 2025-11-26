{
  flake.modules.homeManager.git =
    { modulesPath, ... }:
    {
      imports = [
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
      ];
      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "Ladas552";
            email = "l.tokshalov@gmail.com";
          };
          init.defaultBranch = "master";
          gpg.format = "ssh";
          #it can't read it. permission error or something
          user.signingkey = "~/.ssh/NixToks.pub";
          # commit.gpgsign = true;
          aliases = {
            cm = "commit -m";
            al = "add ./*";
          };
        };
        ignores = [
          ".pre-commit-config.yaml"
          "result"
          "result-bin"
          "result-man"
          "target"
          ".direnv"
        ];
      };
    };
}
