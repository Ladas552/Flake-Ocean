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

  outputs =
    {
      flake-parts,
      self,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      imports = [
        ./pkgs
      ];
      flake =
        let
          # my custom packages
          custom = self.packages.x86_64-linux;
        in
        {
          nixosConfigurations = {
            # My Lenovo 50-70y laptop with nvidia 860M
            NixToks = inputs.nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit inputs custom;
              };

              modules = [
                ./hosts/NixToks
              ];
            };
            # My Acer Swift Go 14 with ryzen 7640U
            NixPort = inputs.nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit inputs custom;
              };

              modules = [
                ./hosts/NixPort
              ];
            };
            # NixOS WSL setup
            NixwsL = inputs.nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit inputs;
              };

              modules = [
                ./hosts/NixwsL
              ];
            };
            # Nix VM for testing major config changes
            NixVM = inputs.nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit inputs;
              };

              modules = [
                ./hosts/NixVM
              ];
            };
            # Nix Iso for live cd
            NixIso = inputs.nixpkgs.lib.nixosSystem {
              specialArgs = {
                inherit inputs;
              };

              modules = [
                ./hosts/NixIso
              ];
            };
          };
          # My android phone/tablet for Termux
          # nixOnDroidConfigurations =
          # let
          #   meta = {
          #     isTermux = true;
          #     host = "NixMux";
          #      = "/data/data/com.termux.nix/files/home/Nix-Is-Unbreakable";
          #     norg = "~/storage/downloads/Norg";
          #     user = "ladas552";
          #   };
          # in
          # {
          #   NixMux = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
          #     extraSpecialArgs = {
          #       inherit inputs;
          #     };
          #     pkgs = import nixpkgs {
          #       system = "aarch64-linux";
          #       overlays = [
          #         (_: prev: {
          #           custom =
          #             (prev.custom or { })
          #             // (import ./pkgs {
          #               inherit (prev) pkgs;
          #               inherit inputs meta ;
          #             });
          #         })
          #       ];
          #       config.allowUnfree = true;
          #     };
          #
          #     modules = [
          #       ./hosts/NixMux
          # ];
        };
    };
}
