{
  description = "Ladas552 NixOS config";

  inputs = {
    # nixpkgs links
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hjem, another home-manager
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
      # No SSG
      inputs.ndg.follows = "";
    };
    # Modules for hjem
    hjem-rum = {
      url = "github:snugnug/hjem-rum";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hjem.follows = "hjem";
      # No SSG
      inputs.ndg.follows = "";
      inputs.treefmt-nix.follows = "";
    };

    nix-on-droid = {
      url = "github:t184256/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
      # No flake compat
      inputs.flake-compat.follows = "";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";

    impermanence.url = "github:nix-community/impermanence";

    stylix.url = "github:nix-community/stylix";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    # Neovim
    nixvim = {
      url = "github:nix-community/nixvim";
      # No SSG
      inputs.nuschtosSearch.follows = "";
    };
    neovim-rocks = {
      url = "github:Ladas552/nvim-rocks-config";
      flake = false;
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
      # No flake compat
      inputs.flake-compat.follows = "";
    };

    # Niri
    # niri.url = "github:sodiboo/niri-flake";

    # Secrets
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
