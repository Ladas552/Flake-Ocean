{
  flake.modules.homeManager.gh = {
    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };
}
