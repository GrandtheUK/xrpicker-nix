{
  description = "xr-picker flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }: 
    let
      pkgs = nixpkgs.legacyPackages;
      lib = nixpkgs.lib;
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = lib.genAttrs supportedSystems;
    in {
      # packages.x86_64-linux.xrpicker = import ./xr-picker.nix nixpkgs;
      # packages.x86_64-linux.default = self.packages.x86_64-linux.xrpicker;
      packages = forAllSystems (system: {
        xr-picker = pkgs.${system}.callPackage ./. { };
        default = self.packages.${system}.xr-picker;
      });
      devShells = forAllSystems (system: {
        default = pkgs.${system}.mkShell {
          packages = [ self.packages.${system}.xr-picker ];
        };
      });
    };
}