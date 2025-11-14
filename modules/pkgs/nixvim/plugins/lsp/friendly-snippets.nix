{
  flake.modules.nixvim.friendly-snippets = {
    performance.combinePlugins.standalonePlugins = [ "friendly-snippets" ];
    plugins.friendly-snippets.enable = true;
  };
}
