{
  flake.modules.homeManager.NixIso =
    { lib, pkgs, ... }:
    {
      # Don't change
      home.stateVersion = "25.11"; # Please read the comment before changing.

      # wget install script

      home.shellAliases = {
        wget-install = "${lib.getExe' pkgs.wget "wget"} https://raw.githubusercontent.com/Ladas552/Flake-Ocean/refs/heads/master/docs/zfs.norg";
        git-install = "${lib.getExe' pkgs.git "git"} clone https://github.com/Ladas552/Flake-Ocean.git";
      };
    };
}
