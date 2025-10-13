{
  flake.modules.nixos.nh = {
    # got direct support from developers, appose to HM version
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.dates = "2 d";
    };
  };
}
