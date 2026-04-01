{
  # Quick git alias
  # gcp "your commit" to push new commit

  perSystem =
    { pkgs, lib, ... }:
    {
      packages.gcp =
        pkgs.writeShellScriptBin "gcp" # bash
          ''
            ${lib.meta.getExe' pkgs.git "git"} add --all && ${lib.meta.getExe' pkgs.git "git"} commit -m "$1" && ${lib.meta.getExe' pkgs.git "git"} push
          '';
    };
}
