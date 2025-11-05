{
  flake.modules.nixvim.dashboard =
    { lib, config, ... }:
    {
      # Depends on Neorg and Snacks.nvim
      plugins.dashboard = {
        enable = true;
        settings = {
          theme = "doom";
          shortcut_type = "number";
          config = {
            header =
              [ ]
              ++ lib.optionals (!config.custom.meta.isTermux) [
                "                                                                "
                "██╗      █████╗ ██████╗  █████╗ ███████╗███████╗███████╗██████╗ "
                "██║     ██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝██╔════╝╚════██╗"
                "██║     ███████║██║  ██║███████║███████╗███████╗███████╗ █████╔╝"
                "██║     ██╔══██║██║  ██║██╔══██║╚════██║╚════██║╚════██║██╔═══╝ "
                "███████╗██║  ██║██████╔╝██║  ██║███████║███████║███████║███████╗"
                "╚══════╝╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚══════╝"
                "                                                                "
              ]
              ++ lib.optionals config.custom.meta.isTermux [
                " "
                "Good living ain't ya?"
                " "
              ];
            center = [
              {
                action = "lua Snacks.picker.recent()";
                desc = " Recent Files";
                icon = "󰥔 ";
                key = "R";
              }
              {
                action = "lua Snacks.picker.projects()";
                desc = " List Projects";
                icon = " ";
                key = "F";
              }
              {
                action = "ene | startinsert";
                desc = " New File";
                icon = " ";
                key = "N";
              }
            ]
            ++ lib.optionals (lib.isString config.custom.meta.norg) [
              {
                action = "Neorg workspace life";
                desc = " Neorg Life";
                icon = "󰠮 ";
                key = "E";
              }
              {
                action = "Neorg workspace work";
                desc = " Neorg Work";
                icon = " ";
                key = "W";
              }
              {
                action = "Neorg journal today";
                desc = " Neorg Journal";
                icon = "󰛓 ";
                key = "J";
              }
            ]
            ++ [
              {
                action = "qa";
                desc = " Quit";
                icon = "󰩈 ";
                key = "Q";
              }
            ];
            footer = [ "Just Do Something Already!" ];
          };
        };
      };
    };
}
