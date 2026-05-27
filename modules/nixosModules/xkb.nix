{
  flake.modules.nixos.xkb = {
    # Configure keymap in X11
    services.xserver = {
      xkb.layout = "us(colemak_dh),kz";
      xkb.variant = "";
      xkb.options = "grp:caps_toggle";
      xkb.model = "pc105";
    };
  };
}
