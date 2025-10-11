{
  flake.modules.nixos.distrobox =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.distrobox ];
      # Example commands because I always forget
      # distrobox create --image archlinux:latest --name ArchLinux --nvidia --home ~/ArchLinux
      # distrobox enter ArchLinux

      virtualisation = {
        podman = {
          enable = true;
          # create a `docker` alias for podman, to use it as a drop-in replacement
          dockerCompat = true;
          # required for containers under podman-compose to be able to talk to each other.
          defaultNetwork.settings.dns_enabled = true;
        };
      };

      # persist for Impermanence
      custom.imp = {
        root.cache.directories = [ "/var/lib/containers" ];
        home.cache.directories = [ ".local/share/containers" ];
      };
    };
}
