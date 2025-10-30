{
  flake.modules.hjem.fish =
    { pkgs, ... }:
    {
      rum.programs.fish = {
        enable = true;
        config = # fish
          ''
            set -gx pure_show_system_time true
            set -gx pure_color_system_time FF78C5
          '';
        plugins = {
          inherit (pkgs.fishPlugins)
            pisces
            bass
            pure
            done
            puffer
            sponge
            ;
        };
        # abbrs =
        #   let
        #     # a little function to not write boilerplate
        #     nix = expansion: {
        #       setCursor = "%";
        #       command = "nix";
        #       expansion = expansion;
        #     };
        #   in
        #   {
        #     "bg" = nix "build github:%";
        #     "bn" = nix "build nixpkgs#%";
        #     "gb" = nix "build github:%";
        #     "gr" = nix "run github:%";
        #     "gs" = nix "shell github:%";
        #     "nb" = nix "build nixpkgs#%";
        #     "nr" = nix "run nixpkgs#%";
        #     "ns" = nix "shell nixpkgs#%";
        #     "rg" = nix "run github:%";
        #     "rn" = nix "run nixpkgs#%";
        #     "sg" = nix "shell github:%";
        #     "sn" = nix "shell nixpkgs#%";
        #   };
      };

      # persist for Impermanence
      custom.imp.home.cache.directories = [ ".local/share/fish" ];
    };
}
