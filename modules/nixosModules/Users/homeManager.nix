{
  flake.modules.nixos.homeManager =
    { inputs, ... }:
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];
      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        backupFileExtension = "bk";
        overwriteBackup = true;
        minimal = true;
      };
    };
}
