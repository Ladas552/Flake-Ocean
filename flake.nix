{
  description = "Ladas552 NixOS config";

  inputs = {
    # nixpkgs links
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";

    # Home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hjem, another home-manager
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
      # No useless inputs
      inputs.nix-darwin.follows = ""; # I don't use nix-darwin machine
      # inputs.smfh.follows = "";
      inputs.smfh.inputs.systems.follows = "systems";
    };
    # Modules for hjem
    hjem-rum = {
      url = "github:snugnug/hjem-rum";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hjem.follows = "hjem";
      # No useless inputs
      inputs.ndg.follows = "";
      inputs.treefmt-nix.follows = "";
    };

    nix-on-droid = {
      url = "github:t184256/nix-on-droid";
      # No useless inputs
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.nix-formatter-pack.follows = "";
      inputs.nixpkgs-docs.follows = "";
      inputs.nmd.follows = "";
      inputs.nixpkgs-for-bootstrap.follows = ""; # I don't boot strap from my config
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      # No useless inputs
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # Neovim
    nvf = {
      # url = "github:notashelf/nvf";
      url = "github:Ladas552/nvf";
      # No useless inputs
      # inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
      inputs.flake-parts.follows = "flake-parts";
      inputs.flake-compat.follows = "";
      inputs.ndg.follows = "";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      # No useless inputs
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
      inputs.systems.follows = "systems";
    };

    # Niri
    niri = {
      url = "git+https://codeberg.org/BANanaD3V/niri-nix";
      # No useless inputs
      inputs.git-hooks.follows = "";
    };

    # Tangled, git hosting
    tangled = {
      url = "git+https://tangled.org/@tangled.org/core";
      # No useless inputs
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.gomod2nix.inputs.flake-utils.inputs.systems.follows = "systems";
      inputs.flake-compat.follows = "";
      inputs.indigo.follows = "";
      inputs.htmx-src.follows = "";
      inputs.htmx-ws-src.follows = "";
      inputs.lucide-src.follows = "";
      inputs.inter-fonts-src.follows = "";
      inputs.actor-typeahead-src.follows = "";
      inputs.ibm-plex-mono-src.follows = "";
      # inputs.sqlite-lib-src.follows = "";
    };

    # Boilerplate
    systems.url = "github:nix-systems/default-linux";

    # Inputs below are either unused, or replaced with nvfetcher inputs

    # Secrets
    # sops-nix = {
    #   url = "github:Mic92/sops-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # impermanence = {
    #   url = "github:nix-community/impermanence";
    #   inputs.nixpkgs.follows = "";
    #   inputs.home-manager.follows = "";
    # };

    # nixos-wsl = {
    #   url = "github:nix-community/NixOS-WSL";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   # No useless inputs
    #   inputs.flake-compat.follows = "";
    # };

    # noctalia = {
    #   url = "github:noctalia-dev/noctalia-shell";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # nixos-hardware.url = "github:nixos/nixos-hardware";

    # Overlays
    # neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
    # emacs-overlay.url = "github:nix-community/emacs-overlay";
    # helix-overlay.url = "github:helix-editor/helix";
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # ghostty.url = "github:ghostty-org/ghostty";
    # ghostty-shaders = {
    #   url = "github:hackr-sh/ghostty-shaders";
    #   flake = false;
    # };
    # ghostty-cursor = {
    #   url = "github:KroneCorylus/shader-playground";
    #   flake = false;
    # };

  };
  outputs =
    inputs:
    let
      # Function to stop using `import-tree` by Vic.
      # Just to lighten the config a bit, written by @llakala https://github.com/llakala/synaptic-standard/blob/main/demo/recursivelyImport.nix
      import-tree = import ./stuff/recursivelyImport.nix { lib = inputs.nixpkgs.lib; };

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
        inherit inputs;
        specialArgs = { inherit modules; };
      }
      {
        imports = import-tree [ ./modules ];
        flake.templates = import ./templates;
      };
}
