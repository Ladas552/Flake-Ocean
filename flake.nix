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
      inputs.smfh.inputs.systems.follows = "systems";
    };
    # Modules for hjem
    hjem-rum = {
      # url = "path:/home/ladas552/Projects/forks/hjem-rum";
      url = "github:ladas552/hjem-rum/chawan";
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

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
      # No useless inputs
      inputs.flake-compat.follows = "";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";

    impermanence = {
      url = "github:nix-community/impermanence";
      inputs.nixpkgs.follows = "";
      inputs.home-manager.follows = "";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      # No useless inputs
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # Neovim
    nvf = {
      url = "github:notashelf/nvf";
      # No useless inputs
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
      inputs.flake-parts.follows = "flake-parts";
      inputs.flake-compat.follows = "";
      inputs.ndg.follows = "";
    };

    # Niri
    niri = {
      url = "git+https://codeberg.org/BANanaD3V/niri-nix";
      # No useless inputs
      inputs.git-hooks.follows = "";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Boilerplate
    systems.url = "github:nix-systems/default-linux";

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
      inherit (inputs.nixpkgs.lib.fileset) toList fileFilter;
      import-tree =
        paths:
        toList (
          fileFilter (file: file.hasExt "nix" && !(inputs.nixpkgs.lib.hasPrefix "_" file.name)) paths
        );
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      imports = import-tree ./modules;
      flake.templates = import ./templates;
    };
}
