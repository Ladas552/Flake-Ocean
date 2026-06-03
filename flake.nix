{
  description = "Ladas552 NixOS config";

  outputs =
    { self, ... }@args:
    let
      # Use inputs from tack, instead of flake inputs
      inputs = (import ./.tack) {
        overrides = args.tackOverrides or { };
      };

      # Function to stop using `import-tree` by Vic.
      # Just to lighten the config a bit, written by @llakala https://github.com/llakala/synaptic-standard/blob/main/demo/recursivelyImport.nix
      import-tree = import ./lib/recursivelyImport.nix { lib = inputs.nixpkgs.lib; };
    in
    inputs.flake-parts.lib.mkFlake
      {
        inherit inputs self;
      }
      {
        imports = import-tree [
          ./modules
          inputs.flake-parts.flakeModules.modules
        ];
        flake.templates = import ./templates;
        # aarch64 and x86_64 Linux systems
        systems = import inputs.systems;
      };
}
