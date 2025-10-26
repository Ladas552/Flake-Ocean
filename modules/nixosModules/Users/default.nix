{
  flake.modules.nixos.users =
    { lib, ... }:
    {

      # setup immutable users for impermanence

      # silence warning about setting multiple user password options
      # https://github.com/NixOS/nixpkgs/pull/287506#issuecomment-1950958990
      # Stolen from Iynaix https://github.com/iynaix/dotfiles/blob/4880969e7797451f4adc3475cf33f33cc3ceb86e/nixos/users.nix#L18-L24
      options = {
        warnings = lib.mkOption {
          apply = lib.filter (
            w: !(lib.hasInfix "If multiple of these password options are set at the same time" w)
          );
        };

        # Username for my normal user
        flake.meta.username = lib.options.mkOption {
          default = "ladas552";
          description = "Normal user in wheel group";
          type = lib.types.str;
        };
      };

      config.users.mutableUsers = false;
    };
}
