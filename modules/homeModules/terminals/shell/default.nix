{
  flake.modules.homeManager.shell =
    { pkgs, config, ... }:
    {
      # Shell programs
      home.packages = with pkgs; [
        wiki-tui
        duf
        unimatrix
        wgetpaste
        # custom.gcp
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
        yy = "nh os switch /persist/home/ladas552/Projects/my_repos/Nix-Is-Unbreakable";
        yyy = "nh os switch -u /persist/home/ladas552/Projects/my_repos/Nix-Is-Unbreakable";
        en = "nvim -c 'cd /persist/home/ladas552/Projects/my_repos/Nix-Is-Unbreakable' /persist/home/ladas552/Projects/my_repos/Nix-Is-Unbreakable/flake.nix";
        enn = "nvim -c 'cd /persist/home/ladas552/Projects/my_repos/Nix-Is-Unbreakable' /persist/home/ladas552/Projects/my_repos/Nix-Is-Unbreakable/hosts/NixPort/default.nix";
        eh = "nvim -c 'cd /persist/home/ladas552/Projects/my_repos/Nix-Is-Unbreakable' /persist/home/ladas552/Projects/my_repos/Nix-Is-Unbreakable/flake.nix";
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
      customhm.imp.home.cache = {
        files = [ ".bash_history" ];
        directories = [
          ".local/share/zoxide"

        ];
      };
    };
}
