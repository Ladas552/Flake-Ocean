{
  flake.modules.nixos.root = args: {
    users.users.root = {
      initialPassword = "pass";
      hashedPasswordFile = args.config.sops.secrets."mystuff/host_pwd".path;
    };
  };
}
