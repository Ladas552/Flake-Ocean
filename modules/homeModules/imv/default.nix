{
  flakes.modules.HM.imv = {

    programs.imv = {
      enable = true;
    };
    # it isn't using HM module settings because I don't know how to make them work. Like actually, imv.settings just outputs a file that binds for imv don't read, idk why
    home.file.".config/imv/config" = {
      source = ./config;
    };
  };
}
