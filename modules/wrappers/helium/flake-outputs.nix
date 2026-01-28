{ self, ... }:
{
  # stolen from @iynaix
  perSystem =
    { pkgs, ... }:
    let
      pname = "helium";
      source = (pkgs.callPackage "${self}/_sources/generated.nix" { }).helium;
      appimageContents = pkgs.appimageTools.extract source;
      helium = pkgs.appimageTools.wrapType2 source // {
        nativeBuildInputs = [ pkgs.makeWrapper ];
        extraInstallCommands = ''
          wrapProgram $out/bin/${pname} \
              --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime=true}}"

          install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
          substituteInPlace $out/share/applications/${pname}.desktop \
            --replace 'Exec=AppRun' 'Exec=${pname}'
          cp -r ${appimageContents}/usr/share/icons $out/share
        '';

        # pass through files from the root fs
        extraBwrapArgs = [
          # chromium policies
          "--ro-bind-try /etc/chromium/policies/managed/default.json /etc/chromium/policies/managed/default.json"
          # xdg scheme-handlers
          "--ro-bind-try /etc/xdg/ /etc/xdg/"
        ];

      };
    in
    {
      packages.helium = helium;
    };
}
