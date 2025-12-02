{
  # cage environment using ghostty
  # special defined scripts and keybinds will be in there
  # scaling doesn't work btw
  flake.modules.nixos.cage-ghostty =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        brightnessctl
      ];

      services.cage = {
        enable = true;
        program = ''${lib.meta.getExe' pkgs.ghostty "ghostty"}'';
        extraArguments = [
          "-m"
          "extend"
        ];
        user = "${config.custom.meta.user}";
        environment = {
          XKB_DEFAULT_LAYOUT = "us,kz";
          XKB_DEFAULT_OPTIONS = "grp:caps_toggle";
        };
      };
    };
}
