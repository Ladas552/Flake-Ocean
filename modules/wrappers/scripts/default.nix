{
  perSystem =
    { pkgs, ... }:
    {
      packages.default = pkgs.writeShellScriptBin "hello" ''echo "Hello World"'';
    };
}
