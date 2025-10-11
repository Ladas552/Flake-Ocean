{
  flake.modules.homeManager.obs =
    { pkgs, ... }:
    {
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          # need to launch game with obs-gamecapture %command% command
          # or this one env OBS_VKCAPTURE=1 %command%
          obs-vkcapture
          obs-pipewire-audio-capture
        ];
      };

      # persist for Impermanence
      customhm.imp.home.cache.directories = [ ".config/obs-studio" ];
    };
}
