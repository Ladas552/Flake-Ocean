{ self, ... }:
{
  flake.modules = {
    hjem.fish =
      { pkgs, config, ... }:
      let
        pkg = self.packages.${pkgs.stdenv.hostPlatform.system}.fish;
        shell-pkgs = with pkgs; [
          bat
          eza
          zoxide
          fzf
          bat
          btop
          fd
          ripgrep
          wiki-tui
          duf
          unimatrix
          wgetpaste
          self.packages.${pkgs.stdenv.hostPlatform.system}.gcp
        ];
        custom.imp.home.cache = {
          files = [ ".bash_history" ];
          directories = [
            ".local/share/zoxide"
            ".local/share/fish"
          ];
        };
      in
      {
        inherit custom;
        packages = shell-pkgs;
        rum.programs.fish = {
          enable = true;
          package = pkg;
          aliases = {
            # Better app names
            v = "nvim";
            # h = "hx";
            cd = "z";
            wiki = "wiki-tui";
            df = "duf";
            copypaste = "wgetpaste";
            cmatrix = "unimatrix -f -s 95";
            ls = "eza";
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
            mcv = "lf ${config.xdg.userDirs.videos.directory}";
            mcm = "lf ${config.xdg.userDirs.music.directory}";
            mcc = "lf ${config.xdg.config.directory}";
            mcp = "lf ${config.xdg.userDirs.pictures.directory}";
          };
          abbrs = config.rum.programs.fish;
        };
      };
    homeManager.fish =
      { pkgs, config, ... }:
      let
        pkg = self.packages.${pkgs.stdenv.hostPlatform.system}.fish;
        shell-pkgs = with pkgs; [
          bat
          eza
          zoxide
          fzf
          bat
          btop
          fd
          ripgrep
          wiki-tui
          duf
          unimatrix
          wgetpaste
          self.packages.${pkgs.stdenv.hostPlatform.system}.gcp
        ];
        custom.imp.home.cache = {
          files = [ ".bash_history" ];
          directories = [
            ".local/share/zoxide"
            ".local/share/fish"
          ];
        };
      in
      {
        inherit custom;
        programs.bash = {
          enable = true;
          enableCompletion = true;
        };

        home = {
          packages = shell-pkgs;
          shellAliases = {
            # Better app names
            v = "nvim";
            # h = "hx";
            cd = "z";
            wiki = "wiki-tui";
            df = "duf";
            copypaste = "wgetpaste";
            cmatrix = "unimatrix -f -s 95";
            ls = "eza";
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
            mcv = "lf ${config.xdg.userDirs.videos}";
            mcm = "lf ${config.xdg.userDirs.music}";
            mcc = "lf ~/.config/";
            mcp = "lf ${config.xdg.userDirs.pictures}";
          };
        };
        programs.fish = {
          enable = true;
          package = pkg;
          preferAbbrs = true;
          shellAbbrs = config.home.shellAliases;
        };
      };
    nixos.fish =
      { pkgs, config, ... }:
      let
        pkg = self.packages.${pkgs.stdenv.hostPlatform.system}.fish;
        shell-pkgs = with pkgs; [
          bat
          eza
          zoxide
          fzf
          bat
          btop
          fd
          ripgrep
          wiki-tui
          duf
          unimatrix
          wgetpaste
          self.packages.${pkgs.stdenv.hostPlatform.system}.gcp
        ];
        custom.imp.home.cache = {
          files = [ ".bash_history" ];
          directories = [
            ".local/share/zoxide"
            ".local/share/fish"
          ];
        };
      in
      {
        inherit custom;
        environment = {
          systemPackages = shell-pkgs;
          shellAliases = {
            # Better app names
            v = "nvim";
            # h = "hx";
            cd = "z";
            wiki = "wiki-tui";
            df = "duf";
            copypaste = "wgetpaste";
            cmatrix = "unimatrix -f -s 95";
            ls = "eza";
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
            mcv = "lf ~/Videos";
            mcm = "lf ~/Music";
            mcc = "lf ~/.config/";
            mcp = "lf ~/Pictures";
          };
        };
        programs.fish = {
          enable = true;
          package = pkg;
          shellAbbrs = config.environment.shellAliases;
        };

      };
    nixOnDroid.fish = {
      # more stuff defined in homeManager.NixMux
      user.shell = "${self.packages."aarch64-linux".fish}/bin/fish";
    };
  };
}
