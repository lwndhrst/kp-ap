{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    nixgl = {
      url = "github:guibou/nixGL";
    };
  };

  outputs = { self, nixpkgs, nixgl }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          nixgl.overlays.default
        ];
      };

    in {
      devShell.${system} = pkgs.mkShell {
        packages = with pkgs; [
          clang-tools
          cmake
          # glsl_analyzer

          curl.dev
          fontconfig.dev
          libglvnd
          libmpg123
          libpulseaudio
          xorg.libX11
          zlib

          # xorg.libXi
          # xorg.libXinerama
          # libGLU

          # pkgs.nixgl.nixGLMesa
        ];
      };
    };
}
