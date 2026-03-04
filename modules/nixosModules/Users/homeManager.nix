{ inputs, ... }:
{
  flake.modules.nixos.homeManager =
    { lib, pkgs, ... }:
    {
      imports = [ inputs.home-manager.nixosModules.home-manager ];
      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        backupCommand = lib.getExe' pkgs.toybox "rm";
        minimal = true;
      };
    };
}
