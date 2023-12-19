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
        version = "1.6.0";
        src = self;
        vendorHash = "";
    };
    lum = pkgs.stdenvNoCC.mkDerivation {
      pname = "self-service-password";
      version = "1.5.4";
      src = self;
      installPhase = ''
        mkdir $out
        cp -r htdocs/ lang/ lib/ templates/ $out/
      '';
    };
  in {
    packages = {
      ssp = ssp;
      default = ssp;
    };
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        php
        php83Packages.composer
      ];
    };
  });
}