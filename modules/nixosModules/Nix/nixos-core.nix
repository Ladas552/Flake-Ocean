# Highly experimental replacment to boot bash scripts with rust
# I tried it once, and now I can't built a system without it that can boot on my laptop
# probably because it mendles with /etc
{ inputs, ... }:
{
  flake.modules.nixos.nixos-core-testing = {
    imports = [ inputs.nixos-core.nixosModules.nixos-core ];
    system.nixos-core.enable = true;
  };
}
