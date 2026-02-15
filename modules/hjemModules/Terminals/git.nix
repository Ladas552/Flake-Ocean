{
  flake.modules.hjem.git = {
    rum.programs.git = {
      enable = true;
      # TODO no gh and openpgp integration like home-manager does, for now
      settings = {
        user = {
          name = "Ladas552";
          email = "l.tokshalov@gmail.com";
        };
        init.defaultBranch = "master";
        gpg.format = "ssh";
        #it can't read it. permission error or something
        user.signingkey = "~/.ssh/NixToks";
        # commit.gpgsign = true;
        aliases = {
          cm = "commit -m";
          al = "add ./*";
        };
      };
      ignore = ''
        .pre-commit-config.yaml
        result
        result-bin
        result-man
        target
        .direnv
      '';
    };
  };
}
