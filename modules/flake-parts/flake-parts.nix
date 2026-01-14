{ inputs, ... }:
{
  imports = [ inputs.flake-parts.flakeModules.modules ];
  # aarch64 and x86_64 Linux systems
  systems = import inputs.systems;
}
