{
  flake.modules.nixos.niri-greetd =
    { config, ... }:
    {
      services.displayManager.autoLogin.enable = true;
      services.displayManager.autoLogin.user = "${config.custom.meta.user}";
      services.greetd = {
        enable = true;
        settings = rec {
          # initial session for autologin
          # https://wiki.archlinux.org/title/Greetd#Enabling_autologin
          initial_session = {
            command = "niri-session";
            user = "${config.custom.meta.user}";
          };
          default_session = initial_session;
        };
      };

      # This is just a memento, not used
      # How to write a custom sessions for display manager
      # services.displayManager.sessionPackages = [
      #   (
      #     (pkgs.writeTextDir "share/wayland-sessions/niri.desktop" ''
      #       [Desktop Entry]
      #       Name=Niri
      #       Comment=why not
      #       Exec=${pkgs.niri}/bin/niri
      #       Type=Application
      #     '').overrideAttrs
      #     (_: {
      #       passthru.providedSessions = [ "niri" ];
      #     })
      #   )
      # ];
    };
}
