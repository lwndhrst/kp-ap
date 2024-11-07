{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    
    custom-nixpkgs = {
      url = "github:lwndhrst/custom-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixgl = {
      url = "github:guibou/nixGL";
    };
  };

  outputs = { self, nixpkgs, custom-nixpkgs, nixgl }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          custom-nixpkgs.overlays.default
          nixgl.overlays.default
        ];
      };

    in {
      devShell.${system} = pkgs.mkShell {
        packages = with pkgs; [
          clang-tools
          cmake
          customPkgs.cinder
        ];
      };
    };
}
