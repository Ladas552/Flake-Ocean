{
  flake.modules.nixos.ollama =
    { pkgs, ... }:
    {
      services.ollama = {
        enable = true;
        package = pkgs.ollama-cuda.override {
          cudaArches = [ "sm_50" ];
          # Target Maxwell (compute 5.0), my nvidia 860m is old
          # It spouse a warning
          # nvcc warning : Support for offline compilation for architectures prior to '<compute/sm/lto>_75' will be removed in a future release (Use -Wno-deprecated-gpu-targets to suppress warning).
          # So I would need to pin the ollama some time in the future
        };

        # I am not adding modules declarativly because the option doesn't work reliably. But `gemma3` seems to work the best on single GPU, and 1b works quite fast, while 4b doesn't die immediately, it's just slow. 2 words per second slow
        host = "[::]";
        environmentVariables = {
          CUDA_VISIBLE_DEVICES = "GPU-30eb34c0-850d-0a8d-fd3f-1f33a8f79bc0";
        };

      };
      # Only allow Tailscale
      networking.firewall.interfaces.tailscale0.allowedTCPPorts = [ 11434 ];
    };
}
