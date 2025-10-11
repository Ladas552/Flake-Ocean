{
  flakes.modules.HM.helix = {
    programs.helix = {
      enable = true;
      # package = if meta.isTermux then pkgs.helix else inputs.helix-overlay.packages.x86_64-linux.default;
    };
  };
}
