{
  flake.modules.nixos.NixwsL =
    { inputs, ... }:
    {
      imports = [
        inputs.nixos-wsl.nixosModules.default
      ];
      networking.hostName = "NixwsL";
      networking.hostId = "e6a70dac";
      boot.supportedFilesystems.zfs = true;
      wsl = {
        enable = true;
        defaultUser = "ladas552";
        startMenuLaunchers = true;
        tarball.configPath = "/home/ladas552/Nix-Is-Unbreakable";
        usbip.enable = true;
        useWindowsDriver = true;
      };

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "24.05"; # Did you read the comment?

      nixpkgs.hostPlatform = "x86_64-linux";
    };
}
