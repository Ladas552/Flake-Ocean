{
  description = "Shell with norgolith";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
  };

  outputs =
    { self, nixpkgs, ... }:
    {
      devShells = {
        x86_64-linux =
          let
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            pk = pkgs.writeShellScriptBin;
          in
          {
            default = pkgs.mkShell {
              packages = with pkgs; [
                rustywind # Organize Tailwind CSS classes
                watchman # required by tailwindcss CLI for watch functionality
                tailwindcss_4
                tailwindcss-language-server
                mprocs # Run multiple commands in parallel

                norgolith
                (pk "serve" "lith dev --drafts")
                (pk "serveh" # bash
                  ''
                    wl-copy "http://$(ip route get 1 | awk '{print $7}'):3030"
                    lith dev --drafts --host
                  ''
                )
                (pk "preview" "lith preview")
                (pk "build" "lith build -m")
                (pk "new" "lith new -k norg posts/$1")
                (pk "edit" "nvim ./content/posts")
                (pk "update" "nix flake update")
              ];
            };
          };
      };
    };
}
