{
  flake.modules.homeManager.helix =
    { modulesPath, ... }:
    {
      imports = [ "${modulesPath}/programs/helix.nix" ];
      programs.helix = {
        enable = true;
        # package = if meta.isTermux then pkgs.helix else inputs.helix-overlay.packages.x86_64-linux.default;
      };
    };
}
