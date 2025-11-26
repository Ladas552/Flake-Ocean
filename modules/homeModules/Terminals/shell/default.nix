{ self, ... }:
{
  flake.modules.homeManager.shell =
    {
      pkgs,
      config,
      modulesPath,
      ...
    }:
    {
      imports = [
        "${modulesPath}/programs/bat.nix"
        "${modulesPath}/programs/btop.nix"
        "${modulesPath}/programs/eza.nix"
        "${modulesPath}/programs/fd.nix"
        "${modulesPath}/programs/fzf.nix"
        "${modulesPath}/programs/ripgrep.nix"
        "${modulesPath}/programs/zoxide.nix"
        # "${modulesPath}/programs/.nix"
        # "${modulesPath}/programs/.nix"
        # "${modulesPath}/programs/.nix"
      ];
      # Shell programs
      home.packages = with pkgs; [
        wiki-tui
        duf
        unimatrix
        wgetpaste
        self.packages.${pkgs.stdenv.hostPlatform.system}.gcp
      ];
      programs = {
        ripgrep.enable = true;
        fd.enable = true;
        btop.enable = true;
        bat.enable = true;
        fzf = {
          enable = true;
          enableFishIntegration = true;
        };
        zoxide = {
          enable = true;
          enableFishIntegration = true;
        };
        eza = {
          enable = true;
          enableFishIntegration = true;
          extraOptions = [ "--icons" ];
        };
        # Makes some rebuilds longer and breaks some complretions
        # But overall, good
        # carapace = {
        #   enable = true;
        # };
      };

      # Bash shell
      programs.bash = {
        enable = true;
        enableCompletion = true;
      };
      home.shellAliases = {
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
        en = "nvim -c 'cd ${config.custom.meta.self}' ${config.custom.meta.self}";
        enn = "nvim -c 'cd ${config.custom.meta.self}' ${config.custom.meta.self}/modules/hosts/${config.custom.meta.hostname}/imports.nix";
        eh = "nvim -c 'cd ${config.custom.meta.self}' ${config.custom.meta.self}";
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

      # persist for Impermanence
      custom.imp.home.cache = {
        files = [ ".bash_history" ];
        directories = [
          ".local/share/zoxide"
        ];
      };
    };
}
