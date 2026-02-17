{
  flake.modules.homeManager.openssh =
    { config, ... }:
    {
      programs.ssh = {
        enable = true;
        # shut that warning up god dammit
        enableDefaultConfig = false;
        matchBlocks."*" = {
          compression = false;
          serverAliveInterval = 0;
          serverAliveCountMax = 3;
          hashKnownHosts = false;
          userKnownHostsFile = "~/.ssh/known_hosts";
          controlPath = "~/.ssh/master-%r@%n:%p";
          forwardAgent = true;
          addKeysToAgent = "yes";
          controlMaster = "auto";
          controlPersist = "10m";
        };

        matchBlocks."github.com" = {
          host = "github.com";
          user = "Ladas552";
          identityFile = [ "~/.ssh/NixToks.pub" ];
        };

        matchBlocks."git.ladas552.me" = {
          host = "git.ladas552.me";
          user = "git";
          identityFile = [ "~/.ssh/NixToks" ];
        };

        matchBlocks."aur.archlinux.org" = {
          host = "aur.archlinux.org";
          user = "aur";
          identityFile = [ "~/.ssh/aur" ];
        };
      };
    };
}
