{
  flake.modules.homeManager.openssh = {
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

      matchBlocks."ladas552" = {
        host = "github.com";
        user = "ladas552";
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
