{ inputs, ... }:
{
  flake.modules.nixos.nix =
    {
      pkgs,
      lib,
      ...
    }:
    {
      # I don't use channels, and I don' care to setup nix-index
      programs.command-not-found.enable = false;
      # Less building text
      documentation = {
        enable = true;
        doc.enable = false;
        man.enable = true;
        nixos.enable = false;
        dev.enable = false;
      };
      # Nix options
      nix = {
        # Make builds run with low priority so my system stays responsive
        daemonCPUSchedPolicy = "idle";
        daemonIOSchedClass = "idle";
        # Better Error messages
        package = pkgs.lixPackageSets.git.lix;
        # Optimize nix experience by removing cache and store garbage, on timer
        optimise.automatic = true;
        # disable channels completely
        channel.enable = false;
        registry = (lib.mapAttrs (_: flake: { inherit flake; }) inputs);
        nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") inputs;
        settings = {
          # error on IFD, It errors on using modules like Stylix tho
          # right now it's true because I IFD a helium wrapper
          allow-import-from-derivation = false;
          # Optimize nix experience by removing cache and store garbage, per command
          # auto-optimise-store = true;
          warn-dirty = false;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          nix-path = lib.mapAttrsToList (n: _: "${n}=flake:${n}") inputs;
          flake-registry = ""; # optional, ensures flakes are truly self-contained
        };
      };
      # nixpkgs options
      nixpkgs.config.allowUnfree = true;
    };
}
