{ self, ... }: {
  flake.modules.nixos.keyd-canary =
    { pkgs, lib, ... }:
    let
      canary = self.packages.${pkgs.stdenv.hostPlatform.system}.canary;
    in
    {
      services.xserver = {
        xkb = {
          layout = lib.mkForce "canary,kz";
          extraLayouts.canary = {
            symbolsFile = canary + "/share/X11/xkb/symbols/canary";
            description = "Canary keyboard layout";
            languages = [ "eng" ];
          };
        };
      };

      services.keyd = {
        enable = true;
        keyboards.default = {
          ids = [
            # Nuphy AirV3
            "19f5:1028:e1045ff3"
            "19f5:1028:bb509bf1"
          ];
          settings = {
            control = {
              # change https://github.com/Apsu/Canary keys when holding Ctrl
              j = "C-z";
              v = "C-x";
              d = "C-c";
              g = "C-v";
              c = "C-a";
              r = "C-s";
              s = "C-d";
              w = "C-q";
              l = "C-w";
              y = "C-e";
              p = "C-r";
              t = "C-f";
              k = "C-t";
              b = "C-g";
              q = "C-b";
              z = "C-y";
              f = "C-h";
              m = "C-n";
              x = "C-u";
              n = "C-j";
              h = "C-m";
              o = "C-i";
              e = "C-k";
              u = "C-o";
              a = "C-l";
              ";" = "C-p";
            };
          };
        };
      };
    };
}
