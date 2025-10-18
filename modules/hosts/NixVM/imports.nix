{ config, ... }:
{
  flake.modules.nixos."hosts/NixVm".imports =
    with config.flake.modules.nixos;
    [
      NixVm
      NixVm-hardware
      # Modules
      niri
      openssh
      fonts
      sops
      zerotier
      systemd-boot
      imp-options
      nix
      general
      # Users
      users
      root
      ladas552
    ]
    # Specific Home-Manager modules
    ++ [
      {
        home-manager.users.ladas552.imports = with config.flake.modules.homeManager; [
          NixVm
          base
          ghostty
          direnv
          imv
          shell
          git
          fish
          imp-options
        ];
      }
    ];
}
