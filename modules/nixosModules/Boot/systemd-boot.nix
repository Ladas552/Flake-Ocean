{
  flake.modules.nixos.systemd-boot =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      boot = {
        initrd.systemd.enable = true;
        supportedFilesystems.ntfs = lib.mkIf (config.custom.meta.hostname == "NixPort") true;
        loader = {
          systemd-boot = {
            enable = true;
            consoleMode = "2";
            edk2-uefi-shell = {
              enable = true;
              sortKey = "x_edk2-uefi-shell";
            };
            windows = lib.mkIf (config.custom.meta.hostname == "NixPort") {
              "11-iot" = {
                title = "Windows 11 IoT";
                efiDeviceHandle = "HD0f";
                sortKey = "z_windows";
              };
            };
            # no wait until boot, press `space` to get the menu
            extraInstallCommands = # sh
              ''
                ${lib.getExe' pkgs.gnused "sed"} -i '/timeout 5/c\timeout 0' /boot/loader/loader.conf
              '';
          };
          efi = {
            efiSysMountPoint = "/boot";
            canTouchEfiVariables = true;
          };
        };
      };
    };
}
