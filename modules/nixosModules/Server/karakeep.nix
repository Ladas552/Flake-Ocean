{
  flake.modules.nixos.karakeep =
    { lib, pkgs, ... }:
    {
      services.karakeep = {
        enable = true;
        browser.exe = "${lib.getExe' pkgs.ungoogled-chromium "chromium"}";
        extraEnvironment = {
          PORT = "9221";
          DISABLE_SIGNUPS = "true";
          OCR_LANGS = "eng,rus";
          INFERENCE_ENABLE_AUTO_TAGGING = "false";
        };
      };
      # Only allow Tailscale
      networking.firewall.interfaces.tailscale0.allowedTCPPorts = [
        9222
        9221
      ];
    };
}
