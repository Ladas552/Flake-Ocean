{
  flake.modules.homeManager.imv =
    { modulesPath, ... }:
    {
      imports = [ "${modulesPath}/programs/imv.nix" ];
      programs.imv.enable = true;
      # it isn't using homeManager module settings because I don't know how to make them work. Like actually, imv.settings just outputs a file that binds for imv don't read, idk why
      home.file.".config/imv/config".source = ./config;
    };
}
