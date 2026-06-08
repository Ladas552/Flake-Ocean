# Enable CUPS to print documents.
# Enable sane for scanner.
{
  flake.modules.nixos.printer =
    { config, pkgs, ... }:
    {
      services.printing = {
        enable = true;
        drivers = [
          # just so you know, I still didn't manage to use my mf3010 printer
          pkgs.canon-cups-ufr2
          pkgs.gutenprint
        ];
      };
      hardware.sane.enable = true;

      users.users."${config.custom.meta.user}".extraGroups = [
        "scanner"
        "lp"
      ];

      # persist for Impermanence
      custom.imp.root.directories = [ "/var/lib/cups" ];
    };
}
