{
  flake.modules.homeManager.git = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Ladas552";
          email = "l.tokshalov@gmail.com";
          # chmod 400
          signingkey = "~/.ssh/NixToks";
        };
        init.defaultBranch = "master";
        gpg.format = "ssh";
        commit.gpgsign = true;
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
