{ inputs, self, ... }:
let
  meta = {
    isTermux = false;
    host = "";
    norg = null;
    self = "";
    user = "ladas552";
  };
in
{
  perSystem =
    {
      pkgs,
      inputs',
      ...
    }:
    {
      packages = {
        # my nvf config
        nvf =
          (inputs.nvf.lib.neovimConfiguration {
            inherit pkgs;
            modules = [ ./nvf ];
            extraSpecialArgs = {
              inherit meta;
            };
          }).neovim;
        # my nixvim config
        nixvim = (
          inputs'.nixvim.legacyPackages.makeNixvimWithModule {
            inherit pkgs;
            module = import ./nixvim/nixvim.nix;
            extraSpecialArgs = {
              inherit inputs' meta;
            };
          }
        );
        nixvim-minimal = (
          inputs'.nixvim.legacyPackages.makeNixvimWithModule {
            inherit pkgs;
            module = import ./nixvim/nixvim-minimal.nix;
            extraSpecialArgs = {
              inherit inputs' meta;
            };
          }
        );
        default = pkgs.writeShellScriptBin "hello" ''echo "Hello World"'';
        restore = pkgs.callPackage ./restore.nix { };
        gcp = pkgs.callPackage ./addcommitpush.nix { };
        rofi-wifi = pkgs.callPackage ./rofi-wifi.nix { };
        word-lookup = pkgs.callPackage ./word-lookup.nix { };
        Subtitlenator = pkgs.callPackage ./Subtitlenator.nix { };
        musnow = pkgs.callPackage ./musnow.nix { };
        wpick = pkgs.callPackage ./wpick.nix { };
        rofi-powermenu = pkgs.callPackage ./rofi-powermenu.nix { inherit self; };
      };
    };
}
