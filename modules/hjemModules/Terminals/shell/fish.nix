{
  flake.modules.hjem.fish =
    { pkgs, config, ... }:
    {
      rum.programs.fish = {
        enable = true;
        config = # fish
          ''
            set -gx pure_show_system_time true
            set -gx pure_color_system_time FF78C5
            abbr --set-cursor --command nix rn run nixpkgs#%
            abbr --set-cursor --command nix bn build nixpkgs#%
            abbr --set-cursor --command nix sn shell nixpkgs#%
            abbr --set-cursor --command nix rg run github:%
            abbr --set-cursor --command nix bg build github:%
            abbr --set-cursor --command nix sg shell github:%
            abbr --set-cursor --command nix nr run nixpkgs#%
            abbr --set-cursor --command nix nb build nixpkgs#%
            abbr --set-cursor --command nix ns shell nixpkgs#%
            abbr --set-cursor --command nix gr run github:%
            abbr --set-cursor --command nix gb build github:%
            abbr --set-cursor --command nix gs shell github:%
          '';
        plugins = {
          # TODO Doesn't work, idk why https://github.com/snugnug/hjem-rum/discussions/154
          inherit (pkgs.fishPlugins)
            pisces
            bass
            pure
            done
            puffer
            sponge
            ;
        };
        abbrs = config.rum.programs.fish.aliases;
        aliases = {
          # Better app names
          v = "nvim";
          # h = "hx";
          cd = "z";
          wiki = "wiki-tui";
          df = "duf";
          copypaste = "wgetpaste";
          cmatrix = "unimatrix -f -s 95";
          # fastfetch = "fastfetch | ${lib.getExe pkgs.lolcat}";
          # Nix mantainense
          clean = "nh clean all";
          yy = "nh os switch ${config.custom.meta.self}";
          yyy = "nh os switch -u ${config.custom.meta.self}";
          en = "cd ${config.custom.meta.self} && nvim ./";
          enn = "cd ${config.custom.meta.self} && nvim ./modules/hosts/${config.custom.meta.hostname}/imports.nix";
          eh = "cd ${config.custom.meta.self} && nvim ./";
          # eh = "hx ${meta.self}";
          # en = "hx ${meta.self}";
          n = "ssh-add ~/.ssh/NixToks";
          # Git
          g = "git";
          gal = "git add ./*";
          gcm = "git commit -m";
          gpr = "git pull --rebase";
          gpu = "git push";
          # Neorg
          j = ''nvim -c "Neorg journal today"'';
          # directories
          mc = "lf";
          # TODO
          # replaced config.xdg.userDirs. with hard paths
          mcv = "lf ${config.xdg.userDirs.videos.directory}";
          mcm = "lf ${config.xdg.userDirs.music.directory}";
          mcc = "lf ${config.xdg.config.directory}";
          mcp = "lf ${config.xdg.userDirs.pictures.directory}";
        };
        # TODO
        # Doesn't work in hjem because it doesn't support submodules, but only concatinated strings
        # abbrs =
        #   let
        #     # a little function to not write boilerplate
        #     nix = expansion: {
        #       setCursor = "%";
        #       command = "nix";
        #       expansion = expansion;
        #     };
        #   in
        #   {
        #     "bg" = nix "build github:%";
        #     "bn" = nix "build nixpkgs#%";
        #     "gb" = nix "build github:%";
        #     "gr" = nix "run github:%";
        #     "gs" = nix "shell github:%";
        #     "nb" = nix "build nixpkgs#%";
        #     "nr" = nix "run nixpkgs#%";
        #     "ns" = nix "shell nixpkgs#%";
        #     "rg" = nix "run github:%";
        #     "rn" = nix "run nixpkgs#%";
        #     "sg" = nix "shell github:%";
        #     "sn" = nix "shell nixpkgs#%";
        #   };
      };

      # persist for Impermanence
      custom.imp.home.cache.directories = [ ".local/share/fish" ];
    };
}
