{
  self,
  config,
  inputs,
  ...
}:
{
  flake.modules =
    let
      settings = {
        #one liners
        hotkey-overlay.skip-at-startup = true;
        xwayland-satellite.off = [ ];
        prefer-no-csd = true;
        screenshot-path = "~/Pictures/screenshots/Niri%Y-%m-%d %H-%M-%S.png";
        layout.default-column-display = "tabbed";
        gestures.hot-corners.off = [ ];
        # Autostart
        spawn-at-startup = [
          #   [
          #     "xfce4-power-manager"
          #     "--daemon"
          #   ]
          # [ "wpaperd" ]
          [
            "thunar"
            "-d"
          ]
        ];
        # theme
        cursor = {
          xcursor-theme = "default";
          xcursor-size = 24;
          hide-after-inactive-ms = 10000;
        };
        # Monitors
        output = [
          {
            _args = [ "eDP-1" ];
            scale = 1.5;
          }
          {
            _args = [ "HDMI-A-1" ];
            # scale = 2.0;
            scale = 1.0;
            mode = "1920x1080@60";
          }
        ];
        # Input Devices
        input = {
          mod-key = "Alt";
          workspace-auto-back-and-forth = true;
          keyboard = {
            xkb.layout = "us,kz";
            xkb.options = "grp:caps_toggle";
          };
          mouse.accel-profile = "flat";
          touchpad = {
            tap = [ ];
            natural-scroll = [ ];
            middle-emulation = [ ];
            scroll-factor = 1.0;
          };
        };
        # Environmental Variables
        environment = {
          DISPLAY = ":0";
          TERMINAL = "ghostty";
          __NV_PRIME_RENDER_OFFLOAD = "1";
          __GLX_VENDOR_LIBRARY_NAME = "nvidia";
          # make flameshot scale with 1.5 niri scale
          # QT_SCALE_FACTOR = "0.667";
        };
        # Looks & UI
        layout = {
          gaps = 8;
          center-focused-column = "never";
          default-column-width.proportion = 0.5;
          border.off = [ ];
          focus-ring = {
            width = 4;
            active-gradient._props = {
              from = "#7700AE";
              to = "#0060FF";
              angle = 45;
            };
          };
          tab-indicator = {
            hide-when-single-tab = true;
            place-within-column = true;
            position = "right";
            gaps-between-tabs = 10.0;
            width = 4.0;
            length._props.total-proportion = 0.1;
            corner-radius = 10.0;
            gap = -8.0;
            active-color = "#BA4B5D";
          };
          preset-column-widths._children = [
            { proportion = 0.25; }
            { proportion = 0.5; }
            { proportion = 0.75; }
            { proportion = 1.0; }
          ];
        };
        # Layer Rules
        layer-rule = [
          {
            # Noctalia wallpaper in overview
            _children = [ { match._props.namespace = "^noctalia-overview*"; } ];
            place-within-backdrop = true;
          }
        ];
        # Window Rules
        window-rule = [
          # Shadows in floating mode
          {
            _children = [ { match._props.is-floating = true; } ];

            shadow.on = [ ];
          }
          {
            _children = [ { match._props.app-id = "mpv"; } ];
            shadow.off = [ ];
          }
          {
            _children = [
              { match._props.title = "Picture-in-Picture"; }
            ];
            default-column-width.fixed = 420;
            default-window-height.fixed = 236;
            default-floating-position._props = {
              x = 50;
              y = 50;
              relative-to = "bottom-right";
            };
            open-focused = false;
            open-floating = true;
          }
          # flameshot
          # thanks @saygo for window rule
          # {
          #   _children = [ { match._props.app-id = ''r#"flameshot"#''; } ];
          #   open-focused = true;
          #   open-floating = true;
          #   open-fullscreen = true;
          # }
          # Full screen/size apps
          {
            _children = [ { match._props.app-id = "steam_proton"; } ];
            default-column-width = { };
          }
          {
            _children = [
              { match._props.app-id = ".qemu-system-x86_64-wrapped"; }
              { match._props.app-id = "steam_app_0"; }
              { match._props.app-id = "darksoulsii.exe"; }
              { match._props.app-id = "steam-"; }
              { match._props.title = "DARK SOULS II"; }
              { match._props.app-id = "osu!"; }
              { match._props.title = "osu!"; }
            ];
            variable-refresh-rate = false;
            open-fullscreen = true;
            default-column-width.proportion = 1.0;
          }
          {
            _children = [
              { match._props.app-id = "librewolf"; }
              { match._props.app-id = "thunderbird"; }
              { match._props.app-id = "vesktop"; }
              { match._props.app-id = "legcord"; }
            ];
            open-maximized-to-edges = true;
            default-column-width.proportion = 1.0;
          }
          # Screencast
          {
            _children = [
              { match._props.app-id._raw = ''r#"^org\.keepassxc\.KeePassXC$"#''; }
              { match._props.app-id._raw = ''r#"^org\.gnome\.World\.Secrets$"#''; }
            ];
            block-out-from = "screencast";
          }
          {
            _children = [
              { match._props.is-window-cast-target = true; }
            ];
            border = {
              on = [ ];
              active-color = "#BA4B5D";
              inactive-color = "#BA4B5D";
            };
          }
        ];
        switch-events = {
          lid-close.spawn = [
            "niri"
            "msg"
            "action"
            "power-off-monitors"
          ];
          lid-open.spawn = [
            "niri"
            "msg"
            "action"
            "power-on-monitors"
          ];
        };
        # Keybinds
        binds = {
          # Noctalia
          "Super+Space".spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "launcher"
            "toggle"
          ];
          "Super+X".spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "sessionMenu"
            "toggle"
          ];
          "Super+L".spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "lockScreen"
            "lock"
          ];
          "Super+D".spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "bar"
            "toggle"
          ];
          # Apps
          "Super+T".spawn = "ghostty";
          # "Super+Space" .spawn =[
          #   "rofi"
          #   "-show"
          # ];
          # "Super+L" .spawn ="swaylock";
          # "Super+E" .spawn ="emacs";
          "Super+N".spawn = [
            "ghostty"
            "-e"
            "nvim"
          ];
          "Super+J".spawn = [
            "ghostty"
            "-e"
            "nvim"
            "-c"
            "Neorg journal today"
          ];
          "Super+M".spawn = [
            "ghostty"
            "-e"
            "rmpc"
          ];
          "Super+H".spawn = [
            "ghostty"
            "-e"
            "btop"
          ];
          "Super+G".spawn = [
            "ghostty"
            "-e"
            "qalc"
          ];
          # GUI apps
          "Super+F".spawn = "thunar";
          "Super+W".spawn = "librewolf";
          "Shift+Super+W".spawn = "helium";
          # MPD
          "Shift+Alt+P" = {
            spawn = [
              "mpc"
              "toggle"
            ];
            _props.allow-when-locked = true;
          };
          "Shift+Alt+N" = {
            spawn = [
              "mpc"
              "next"
            ];
            _props.allow-when-locked = true;
          };
          "Shift+Alt+B" = {
            spawn = [
              "mpc"
              "prev"
            ];
            _props.allow-when-locked = true;
          };
          "Shift+Alt+K" = {
            spawn = [
              "mpc"
              "volume"
              "-5"
            ];
            _props.allow-when-locked = true;
          };
          "Shift+Alt+L" = {
            spawn = [
              "mpc"
              "volume"
              "+5"
            ];
            _props.allow-when-locked = true;
          };
          "Shift+Alt+C".spawn = [
            "mpc"
            "clear"
          ];
          "Shift+Alt+M".spawn = [ "musnow.sh" ];

          # Scripts
          "Super+C".spawn = [ "word-lookup.sh" ];
          # "Super+X" .spawn =[ "powermenu.sh" ];
          #Example volume keys mappings for PipeWire & WirePlumber.
          #The allow-when-locked=true property makes them work even when the session is locked.
          "XF86AudioRaiseVolume" = {
            spawn = [
              "pamixer"
              "-i"
              "2"
              # "wpctl"
              # "set-volume"
              # "@DEFAULT_AUDIO_SINK@"
              # "0.02+"
            ];
            _props.allow-when-locked = true;
          };
          "XF86AudioLowerVolume" = {
            spawn = [
              "pamixer"
              "-d"
              "2"
              # "wpctl"
              # "set-volume"
              # "@DEFAULT_AUDIO_SINK@"
              # "0.02-"
            ];
            _props.allow-when-locked = true;
          };
          "XF86AudioMute" = {
            spawn = [
              "pamixer"
              "-t"
              # "wpctl"
              # "set-mute"
              # "@DEFAULT_AUDIO_SINK@"
              # "toggle"
            ];
            _props.allow-when-locked = true;
          };
          "XF86AudioMicMute" = {
            spawn = [
              "wpctl"
              "set-mute"
              "@DEFAULT_AUDIO_SOURCE@"
              "toggle"
            ];
            _props.allow-when-locked = true;
          };

          # Brightnes
          "XF86MonBrightnessUp" = {
            spawn = [
              "brightnessctl"
              "set"
              "10%+"
            ];
            _props.allow-when-locked = true;
          };
          "XF86MonBrightnessDown" = {
            spawn = [
              "brightnessctl"
              "set"
              "10%-"
            ];
            _props.allow-when-locked = true;
          };

          # shows a list of important hotkeys.
          "Super+Shift+T".show-hotkey-overlay = [ ];
          # Screenshots
          # was testing if it got better quility
          # "Print" .spawn =[
          #   "sh"
          #   "-c"
          #   "${lib.getExe pkgs.slurp} | ${lib.getExe pkgs.grim} -g -"
          # ];
          "Print".screenshot = [ ];
          # "Print" .spawn =[
          #   "flameshot"
          #   "gui"
          # ];
          # "Shift+Alt+Print" .spawn =[ "flameshot-ocr" ];
          "Shift+Print".screenshot-screen = [ ];
          "Alt+Print".screenshot-window = [ ];
          # Window Management
          "Super+Q".close-window = [ ];
          # Floating Windows
          "Ctrl+Alt+S".toggle-window-floating = [ ];
          "Super+Tab".switch-focus-between-floating-and-tiling = [ ];
          # Tabbed layout
          "Ctrl+Alt+A".toggle-column-tabbed-display = [ ];

          "Super+Left".focus-column-left-or-last = [ ];
          "Super+Down".focus-window-down-or-top = [ ];
          "Super+Up".focus-window-up-or-bottom = [ ];
          "Super+Right".focus-column-right-or-first = [ ];
          "Super+A".focus-column-left-or-last = [ ];
          "Super+S".focus-column-right-or-first = [ ];

          "Super+Shift+Left".move-column-left = [ ];
          "Super+Shift+Down".move-window-down = [ ];
          "Super+Shift+Up".move-window-up = [ ];
          "Super+Shift+Right".move-column-right = [ ];
          "Super+Shift+A".move-column-left = [ ];
          "Super+Shift+S".move-column-right = [ ];
          # "Super+Ctrl+H" .move-column-left=[];
          # "Super+Ctrl+J" .move-window-down=[];
          # "Super+Ctrl+K" .move-window-up=[];
          # "Super+Ctrl+L" .move-column-right=[];

          "Super+Page_Up".focus-column-first = [ ];
          "Super+Page_Down".focus-column-last = [ ];
          "Super+Shift+Page_Up".move-column-to-first = [ ];
          "Super+Shift+Page_Down".move-column-to-last = [ ];

          "Super+Ctrl+Right".focus-monitor-right = [ ];
          "Super+Ctrl+Down".focus-monitor-down = [ ];
          "Super+Ctrl+Up".focus-monitor-up = [ ];
          "Super+Ctrl+Left".focus-monitor-left = [ ];

          "Super+Shift+Ctrl+Left".move-column-to-monitor-left = [ ];
          "Super+Shift+Ctrl+Down".move-column-to-monitor-down = [ ];
          "Super+Shift+Ctrl+Up".move-column-to-monitor-up = [ ];
          "Super+Shift+Ctrl+Right".move-column-to-monitor-right = [ ];
          "Super+Shift+H".move-column-to-monitor-left = [ ];
          "Super+Shift+J".move-column-to-monitor-down = [ ];
          "Super+Shift+K".move-column-to-monitor-up = [ ];
          "Super+Shift+L".move-column-to-monitor-right = [ ];

          "Super+Ctrl+A".focus-workspace-up = [ ];
          "Super+Ctrl+S".focus-workspace-down = [ ];

          "Super+Shift+Ctrl+A".move-column-to-workspace-up = [ ];
          "Super+Shift+Ctrl+S".move-column-to-workspace-down = [ ];
          # Mouse scroll
          "Super+WheelScrollDown" = {
            focus-workspace-down = [ ];
            _props.cooldown-ms = 150;
          };
          "Super+WheelScrollUp" = {
            focus-workspace-up = [ ];
            _props.cooldown-ms = 150;
          };
          "Super+Ctrl+WheelScrollDown" = {
            move-column-to-workspace-down = [ ];
            _props.cooldown-ms = 150;
          };
          "Super+Ctrl+WheelScrollUp" = {
            move-column-to-workspace-up = [ ];
            _props.cooldown-ms = 150;
          };

          "Super+WheelScrollRight".focus-column-right = [ ];
          "Super+WheelScrollLeft".focus-column-left = [ ];
          "Super+Ctrl+WheelScrollRight".move-column-right = [ ];
          "Super+Ctrl+WheelScrollLeft".move-column-left = [ ];

          "Super+Shift+WheelScrollDown".focus-column-right = [ ];
          "Super+Shift+WheelScrollUp".focus-column-left = [ ];
          "Super+Ctrl+Shift+WheelScrollDown".move-column-right = [ ];
          "Super+Ctrl+Shift+WheelScrollUp".move-column-left = [ ];

          # Touchpad gestures
          ## Workspaces
          "Super+Shift+TouchpadScrollUp".move-column-to-workspace-up = [ ];
          "Super+Shift+TouchpadScrollDown".move-column-to-workspace-down = [ ];
          "Super+TouchpadScrollUp".focus-workspace-up = [ ];
          "Super+TouchpadScrollDown".focus-workspace-down = [ ];
          ## Collumns
          "Super+TouchpadScrollRight".focus-column-right = [ ];
          "Super+TouchpadScrollLeft".focus-column-left = [ ];

          "Super+Shift+TouchpadScrollRight".move-column-right = [ ];
          "Super+Shift+TouchpadScrollLeft".move-column-left = [ ];
          # Workspaces
          "Super+1".focus-workspace = 1;
          "Super+2".focus-workspace = 2;
          "Super+3".focus-workspace = 3;
          "Super+Shift+1".move-column-to-workspace = 1;
          "Super+Shift+2".move-column-to-workspace = 2;
          "Super+Shift+3".move-column-to-workspace = 3;
          # Switches focus between the current and the previous workspace.

          # "Super+Tab" .focus-workspace-previous=[];

          "Super+Comma".consume-window-into-column = [ ];
          "Super+Period".expel-window-from-column = [ ];
          # There are also commands that consume or expel a single window to the side.
          "Super+BracketLeft".consume-or-expel-window-left = [ ];
          "Super+BracketRight".consume-or-expel-window-right = [ ];
          # Resize

          "Super+R".switch-preset-column-width = [ ];
          "Super+Alt+F".maximize-column = [ ];
          "Super+Alt+C".center-column = [ ];
          "Super+Shift+F".fullscreen-window = [ ];
          "Super+Ctrl+Shift+F".toggle-windowed-fullscreen = [ ];

          "Alt+Ctrl+Left".set-column-width = "-10%";
          "Alt+Ctrl+Right".set-column-width = "+10%";

          "Alt+Ctrl+Up".set-window-height = "-10%";
          "Alt+Ctrl+Down".set-window-height = "+10%";

          "Super+Ctrl+Shift+Q".quit = [ ];

          "Super+Shift+P".power-off-monitors = [ ];
          # Knob binds

          ## Brightness with a knob
          "Super+XF86AudioRaiseVolume" = {
            _props.allow-when-locked = true;
            spawn = [

              "brightnessctl"
              "set"
              "2%+"
            ];
          };
          "Super+XF86AudioLowerVolume" = {
            _props.allow-when-locked = true;
            spawn = [
              "brightnessctl"
              "set"
              "2%-"
            ];
          };

          ## Change mpd track with a knob
          "Shift+Alt+XF86AudioRaiseVolume" = {
            _props.allow-when-locked = true;
            spawn = [
              "mpc"
              "next"
            ];
          };
          "Shift+Alt+XF86AudioLowerVolume" = {
            _props.allow-when-locked = true;
            spawn = [
              "mpc"
              "prev"
            ];
          };
          "Shift+Alt+XF86AudioMute" = {
            _props.allow-when-locked = true;
            spawn = [
              "mpc"
              "shuffle"
            ];
          };

          ## Change collumn size with a knob
          "Alt+Ctrl+XF86AudioRaiseVolume".set-column-width = "+1%";
          "Alt+Ctrl+XF86AudioLowerVolume".set-column-width = "-1%";
          "Alt+Ctrl+XF86AudioMute".switch-preset-column-width = [ ];
        };
      };
    in
    {
      nixos.niri-flake =
        { pkgs, ... }:
        {
          imports = [
            inputs.niri.nixosModules.default
            config.flake.modules.nixos.niri-greetd
          ];

          # To use master branch niri without building rust
          nix.settings = {
            extra-substituters = [
              "https://niri-nix.cachix.org"
            ];
            extra-trusted-public-keys = [
              "niri-nix.cachix.org-1:SvFtqpDcf7Sm1SMJdby1/+Y+6f3Yt3/3PMcSTKPJNJ0="
            ];
          };
          nixpkgs.overlays = [ inputs.niri.overlays.niri-nix ];
          # Niri using flake
          # uncomment the niri inputs in flake.nix to use this
          programs.niri = {
            enable = true;
            useNautilus = false;
            # package = pkgs.niri-unstable;
            # I use my own portal settings
            withXDG = false;
          };

          environment.systemPackages = with pkgs; [
            xwayland-satellite
            brightnessctl
            xfce4-power-manager
            # self.packages.${pkgs.stdenv.hostPlatform.system}.rofi-powermenu
            self.packages.${pkgs.stdenv.hostPlatform.system}.wpick
          ];

          environment.variables = {
            NIXOS_OZONE_WL = "1";

            ELECTRON_LAUNCH_FLAGS = "--enable-wayland-ime --wayland-text-input-version=3 --enable-features=WaylandLinuxDrmSyncobj";
          };

          xdg.portal = {
            enable = true;
            xdgOpenUsePortal = true;
            extraPortals = [
              pkgs.xdg-desktop-portal-gnome
              pkgs.xdg-desktop-portal-gtk
            ];
            config = {
              niri."org.freedesktop.impl.portal.FileChooser" = "gtk";
              niri.default = "gnome";
              common.default = "gnome";
              obs.default = "gnome";
            };
          };
        };
      homeManager.niri-flake = {
        imports = [ inputs.niri.homeModules.default ];
        wayland.windowManager.niri = {
          enable = true;
          inherit settings;
        };
      };
      hjem.niri-flake =
        { pkgs, ... }:
        {
          xdg.config.files."niri/config.kdl".text = inputs.niri.lib.validatedConfigFor pkgs.niri (
            inputs.niri.lib.mkNiriKDL settings
          );
        };
    };
}
