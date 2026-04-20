{ modules, ... }:
{
  flake.modules = {
    nixos.noct =
      { pkgs, lib, ... }:
      let
        noct =
          (pkgs.callPackage "${modules.noctalia-dev.src}/nix/package.nix" {
            calendarSupport = false;
            quickshell = pkgs.callPackage "${modules.noctalia-qs.src}/nix/package.nix" {
              gitRev = "dirty";
              version = "dirty";
            };
            # Use my icon set in noctalia, thanks @iynaix
          }).overrideAttrs
            (o: {
              preFixup = (o.preFixup or "") + /* sh */ ''
                qtWrapperArgs+=(
                  --set QT_QPA_PLATFORMTHEME gtk3
                )
              '';
            });
      in
      {
        environment.systemPackages = with pkgs; [
          noct
          gpu-screen-recorder
        ];
      };
    hjem.noct = {
      xdg.config.files = {
        "noctalia/settings.json".source = ./noct/settings.json;
        "noctalia/colors.json".source = ./noct/colors.json;
        "noctalia/plugins.json".source = ./noct/plugins.json;
        "noctalia/plugins/screen-recorder/settings.json".source = ./noct/recorder-settings.json;
      };
      # persist for Impermanence
      custom.imp.home.cache.directories = [
        ".cache/noctalia"
        ".config/noctalia/plugins"
      ];
    };
  };
}
