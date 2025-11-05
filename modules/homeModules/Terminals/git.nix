{
  flake.modules.homeManager.git = {
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
