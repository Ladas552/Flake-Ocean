{
  flake.modules.homeManager.base =
    { config, modulesPath, ... }:
    {
      imports = [
        "${modulesPath}/programs/fish.nix"
        "${modulesPath}/programs/home-manager.nix"
        "${modulesPath}/programs/man"
        # I hate this module `modules/misc/ssh-auth-sock.nix`
        "${modulesPath}/services/ssh-agent.nix"
        "${modulesPath}/services/ssh-tpm-agent.nix"
        "${modulesPath}/services/gpg-agent.nix"
        "${modulesPath}/services/proton-pass-agent.nix"
        "${modulesPath}/services/yubikey-agent.nix"

      ];

      # Me
      home.username = "${config.custom.meta.user}";
      home.homeDirectory = "/home/${config.custom.meta.user}";
      # Environment and Dependencies
      xdg = {
        enable = true;
      };
      # home-manager binary for Home-Manager standalone
      # I use home-manager as a module
      programs.home-manager.enable = false;

      programs.man.enable = false;

      # I use hjem for user services
      systemd.user.enable = false;
    };
}
