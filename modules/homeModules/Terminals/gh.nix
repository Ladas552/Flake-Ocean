{
  flake.modules.homeManager.gh =
    { modulesPath, ... }:
    {
      imports = [ "${modulesPath}/programs/gh.nix" ];
      programs.gh = {
        enable = true;
        gitCredentialHelper.enable = true;
      };
    };
}
