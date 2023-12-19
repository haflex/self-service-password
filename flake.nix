{

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
    flake-utils.url = github:numtide/flake-utils;
  };

  description = "self-service-password";

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = nixpkgs.legacyPackages.${system};
    ssp = pkgs.php.buildComposerProject {
      pname = "self-service-password";
      src = self;
      version = "1.6.0";
      vendorHash = "sha256-kOO8E0+mYtq7WqkPpYtfRCvEBu+Z25uPD5uNrJqZ+/c=";
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
  });
}