{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
    flake-utils.url = github:numtide/flake-utils;
  };

  description = "self-service-password";

  outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachDefaultSystem (system: let pkgs = nixpkgs.legacyPackages.${system}; in
    let
      ssp = pkgs.callPackage nix/package.nix {
        inherit self;
        buildComposerProject = pkgs.php.buildComposerProject;
        smarty3 = pkgs.smarty3;
      };
    in {
      packages = {
        ssp = ssp;
        default = ssp;
      };
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.php
          pkgs.php83Packages.composer
          pkgs.smarty3
        ];
      };
    }
  ) // {
    nixosModules.default = import ./nix/module.nix {inherit self;};
    nixosConfigurations.container = import ./nix/container.nix {inherit nixpkgs self;};
 };
}