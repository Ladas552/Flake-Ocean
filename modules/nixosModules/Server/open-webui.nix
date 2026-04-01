{
  flake.modules.nixos.open-webui = {
    services.open-webui = {
      enable = true;
      port = 1212;
      host = "0.0.0.0";
      environment = {
        ANONYMIZED_TELEMETRY = "False";
        DO_NOT_TRACK = "True";
        SCARF_NO_ANALYTICS = "True";
        OLLAMA_BASE_URL = "http://127.0.0.1:11434";
        # Disable authentication
        WEBUI_AUTH = "False";
      };
    };
    # Only allow Tailscale
    networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 1212 ];
  };
}
