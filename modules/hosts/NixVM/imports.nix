{ config, ... }:
let
  custom.meta = {
    hostname = "NixVm";
    self = "~/Flake-Ocean";
    norg = "~/Documents/Norg";
  };
in
{
  flake.modules.nixos."hosts/NixVm".imports = with config.flake.modules.nixos; [
    { inherit custom; }
    NixVm
    NixVm-hardware
    # Modules
    niri-flake
    noct
    openssh
    fonts
    sops
    zerotier
    systemd-boot
    cat-mocha
    nix
    general
    fish
    # Users
    root
    ladas552
  ];
}
