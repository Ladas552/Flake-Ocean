{ inputs, ... }:
{
  flake.modules = {
    nixos.noct =
      { pkgs, ... }:
      let
        noct =
          (inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
            calendarSupport = true;
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
        "noctalia/settings.json".source = ./settings.json;
        "noctalia/colors.json".source = ./colors.json;
        "noctalia/plugins.json".source = ./plugins.json;
        "noctalia/plugins/screen-recorder/settings.json".source = ./recorder-settings.json;
      };
      # persist for Impermanence
      custom.imp.home.cache.directories = [
        ".cache/noctalia"
        ".config/noctalia/plugins"
      ];
    };
  };
}
