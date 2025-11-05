{
  flake.modules.homeManager.nushell = {
    programs.nushell = {
      enable = true;
      settings = {
        buffer_editor = "nvim";
        show_banner = false;
        render_right_prompt_on_last_line = true;
        float_precision = 2;
        table = {
          mode = "markdown";
        };
      };
      envFile.text = # nu
        ''
          $env.PROMPT_COMMAND_RIGHT = ""
        '';
    };

    # persist for Impermanence
    custom.imp.home.cache.files = [ ".config/nushell/history.txt" ];
  };
}
