{ inputs, ... }:
{
  flake.modules.nixos.sops =
    { pkgs, ... }:
    {
      imports = [ inputs.sops-nix.nixosModules.sops ];

      environment.systemPackages = [ pkgs.sops ];

      sops.defaultSopsFile = ../../../secrets/secrets.yaml;
      sops.defaultSopsFormat = "yaml";

      sops.age.sshKeyPaths = [ "/persist/home/ladas552/.ssh/NixToks" ];
      sops.age.keyFile = "/persist/home/ladas552/.config/sops/age/keys.txt";

      sops.secrets."mystuff/host_pwd".neededForUsers = true;
      sops.secrets."mystuff/host_pwd" = { };

      # persist for Impermanence
      custom.imp.home.directories = [ ".config/sops/" ];
    };
}
