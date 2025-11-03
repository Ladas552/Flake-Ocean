{ self, ... }:
{
  # Hyprland
  flake.modules = {
    # autologin into hyprland
    nixos.hyprland-greetd =
      { pkgs, ... }:
      {
        services.displayManager.autoLogin.enable = true;
        services.displayManager.autoLogin.user = "ladas552";
        services.greetd = {
          enable = true;
          settings = rec {
            # initial session for autologin
            # https://wiki.archlinux.org/title/Greetd#Enabling_autologin
            initial_session = {
              command = "uwsm start ${pkgs.hyprland}/share/wayland-sessions/hyprland.desktop";
              user = "ladas552";
            };
            default_session = initial_session;
          };
        };
      };
    # hyprland
    nixos.hyprland =
      { pkgs, ... }:
      {
        programs.hyprland = {
          enable = true;
          withUWSM = true;
        };

        environment.systemPackages = with pkgs; [
          brightnessctl
          xfce.xfce4-power-manager
          self.packages.${pkgs.stdenv.hostPlatform.system}.rofi-powermenu
          self.packages.${pkgs.stdenv.hostPlatform.system}.wpick
        ];

        environment.variables = {
          NIXOS_OZONE_WL = "1";
          ELECTRON_LAUNCH_FLAGS = "--enable-wayland-ime --wayland-text-input-version=3 --enable-features=WaylandLinuxDrmSyncobj";
        };

        # persist for Impermanence
        custom.imp.home.cache.directories = [ ".cache/hyprland" ];
      };

    # hyprland dotfiles
    homeManager.hyprland =
      { pkgs, ... }:
      {

        wayland.windowManager.hyprland = {
          enable = true;
          systemd.enable = false;
          plugins = with pkgs; [ ];
          settings = {
            # monitor = lib.mkIf (meta.host == "NixToks") "eDP-1, 1920x1080@60, 0x0, 1";

            # Options
            general = {
              # Mouse control
              resize_on_border = true;
            };

            input = {
              # Keyboard layout
              kb_layout = "us,kz";
              kb_options = "grp:caps_toggle";
              numlock_by_default = true;
              # Mouse inputs
              accel_profile = "flat";
              touchpad = {
                disable_while_typing = false;
                natural_scroll = true;
                scroll_factor = 0.2;
              };
            };

            misc = {
              font_family = "JetBrainsMono NFM Regular";
              splash_font_family = "splash_font_family";
            };
            ecosystem = {
              no_update_news = true;
              no_donation_nag = true;
            };

            binds = {
              workspace_back_and_forth = true;
              allow_workspace_cycles = true;
            };

            xwayland.force_zero_scaling = true;

            # Nvidia ENV
            opengl.nvidia_anti_flicker = false;
            env = [
              "LIBVA_DRIVER_NAME,nvidia"
              "__GLX_VENDOR_LIBRARY_NAME,nvidia"
            ];

            # Keybinds
            bind = [
              "SUPER, T, exec, ghostty"
              "SUPER, W, exec, floorp"
              "SUPER, space, exec, rofi -show"
              "SUPER, 1, workspace, 1"
              "SUPER, 2, workspace, 2"
            ];

            # autostart
            exec-once = [
              "thunar -d"
              "xfce4-power-manager --daemon"
            ];

          };
        };

      };
  };
}
