{
  lib,
  pkgs,
  ...
}:
{
  plugins.lsp.servers.nil_ls = {
    enable = true;
    settings = {
      flake.autoArchive = false;
    };
  };
  plugins.conform-nvim.settings = {
    formatters_by_ft.nix = [ "nixfmt" ];
    formatters.nixfmt.command = lib.getExe' pkgs.nixfmt "nixfmt";
  };
}
