{
  flake.modules.nixos.imp =
    {
      inputs,
      config,
      lib,
      ...
    }:
    let
      cfg = config.custom.imp;
      cfghm = config.home-manager.users."ladas552".customhm.imp;
    in

    {
      # persist mount
      fileSystems."/persist" = {
        device = "zroot/persist";
        fsType = "zfs";
        neededForBoot = true;
      };
      # replace the root mount with tmpfs
      # wipes everything if you don't have proper persists, be warned
      fileSystems."/" = lib.mkForce {
        device = "tmpfs";
        fsType = "tmpfs";
        neededForBoot = true;
        options = [
          "defaults"
          # whatever size feels comfortable, smaller is better
          "size=1G"
          "mode=755"
        ];
      };

      services.sanoid = {
        enable = true;
        datasets = lib.mkForce {
          "zroot/persist" = {
            hourly = 50;
            daily = 15;
            weekly = 3;
            monthly = 1;
          };
        };
      };
      # clean /tmp
      boot.tmp.cleanOnBoot = true;

      # sudo lectures about rules when using root
      security.sudo.extraConfig = "Defaults lecture=never";

      # essential persists
      environment.persistence = {
        "/persist" = {
          hideMounts = true;
          files = lib.unique cfg.root.files;
          directories = lib.unique (
            [
              "/var/log"
              "/var/lib/nixos"
            ]
            ++ cfg.root.directories
          );
          users."ladas552" = {
            files = lib.unique cfghm.home.files;
            directories = lib.unique ([ ] ++ cfg.home.directories ++ cfghm.home.directories);
          };
        };
        "/cache" = {
          hideMounts = true;
          files = lib.unique cfg.root.cache.files;
          directories = lib.unique cfg.root.cache.directories;
          users."ladas552" = {
            files = lib.unique (cfg.home.cache.files ++ cfghm.home.cache.files);
            directories = lib.unique (cfg.home.cache.directories ++ cfghm.home.cache.directories);
          };
        };
      };
    };
}
