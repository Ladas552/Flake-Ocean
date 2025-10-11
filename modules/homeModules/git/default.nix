{
  flakes.modules.HM.git = {
    programs.git = {
      enable = true;
      userName = "Ladas552";
      userEmail = "l.tokshalov@gmail.com";
      extraConfig = {
        init.defaultBranch = "master";
        gpg.format = "ssh";
        #it can't read it. permission error or something
        user.signingkey = "~/.ssh/NixToks.pub";
        # commit.gpgsign = true;
      };
      aliases = {
        cm = "commit -m";
        al = "add ./*";
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
