{
  perSystem =
    { pkgs, ... }:
    let
      inherit (pkgs)
        libqalculate
        writeShellApplication
        ;
    in
    {
      packages.libqalculate = writeShellApplication {
        name = "qalc";

        runtimeInputs = [
          libqalculate
        ];

        text = # bash
          ''
            qalc -s "angle 2" -s "decimal comma off" -s "upxrates 1" -s "autocalc on"
          '';
      };
    };
}
