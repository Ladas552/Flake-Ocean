{
  # cage environment using ghostty
  # special defined scripts and keybinds will be in there
  # scaling doesn't work btw
  flake.modules.nixos.cage-ghostty =
    { pkgs, lib, ... }:
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
        user = "ladas552";
        environment = {
          XKB_DEFAULT_LAYOUT = "us,kz";
          XKB_DEFAULT_OPTIONS = "grp:caps_toggle";
        };
      };
    };
}
