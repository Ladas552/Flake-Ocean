{
  flake.modules.homeManager.swaylock =
    { modulesPath, ... }:
    {
      imports = [ "${modulesPath}/programs/swaylock.nix" ];
      programs.swaylock.enable = true;
    };
}
