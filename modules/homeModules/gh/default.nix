{
  flakes.modules.HM.gh = {
    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };
}
