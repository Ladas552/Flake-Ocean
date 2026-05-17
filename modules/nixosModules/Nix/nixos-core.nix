# Highly experimental replacment to boot bash scripts with rust
{ inputs, ... }:
{
  flake.modules.nixos.nixos-core-testing = {
    imports = [ inputs.nixos-core.nixosModules.nixos-core ];
    system.nixos-core.enable = true;
  };
}
