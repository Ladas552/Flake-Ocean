{
  description = "Ladas552 NixOS config";

  outputs =
    { self, ...}@args:
    let
      inputs = (import ./.tack) {
        overrides = args.tackOverrides or { };
      };

      # Function to stop using `import-tree` by Vic.
      # Just to lighten the config a bit, written by @llakala https://github.com/llakala/synaptic-standard/blob/main/demo/recursivelyImport.nix
      import-tree = import ./lib/recursivelyImport.nix { lib = inputs.nixpkgs.lib; };

      # a way to fetch nix files via nvfetcher and import them in the config
      # basically parse the json crated by nvfetcher, and use fetchTarball
      # nvfetcher uses fetchers from nixpkgs by default, so we can't use the generated.nix file here
      # but can everywhere else.
      sourcesJson = builtins.fromJSON (builtins.readFile ./_sources/generated.json);

      modules = builtins.mapAttrs (
        name: value:
        let
          src = fetchTarball {
            url = "${value.src.url}/archive/${value.src.rev}.tar.gz";
            sha256 = value.src.sha256;
          };
        in
        value // { inherit src; }
      ) sourcesJson;
    in
    inputs.flake-parts.lib.mkFlake
      {
        inherit inputs self;
        specialArgs = { inherit modules; };
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
