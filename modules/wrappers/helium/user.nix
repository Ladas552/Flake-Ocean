{ self, ... }:
{
  flake.modules.hjem.helium =
    { pkgs, ... }:
    {
      packages = [ self.packages.${pkgs.stdenv.hostPlatform.system}.helium ];

      # Add widevine support, inspired from this comment:
      # DRM
      # https://github.com/imputnet/helium/issues/116#issuecomment-3668370766
      # https://github.com/Michael-C-Buckley/nixos/blob/319f441b799e7c2db7eabd77524f5bbc3d74a3d2/modules/hjem/configs/applications/helium.nix#L15
      # xdg.config.files."net.imput.helium/WidevineCdm/latest-component-updated-widevine-cdm".text = ''
      #   {"Path":"${pkgs.widevine-cdm}/share/google/chrome/WidevineCdm"}
      # '';

      custom.imp.home.cache.directories = [
        ".cache/net.imput.helium"
        ".config/net.imput.helium"
      ];
    };
}
