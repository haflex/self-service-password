{

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
    flake-utils.url = github:numtide/flake-utils;
  };

  description = "self-service-password";

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = nixpkgs.legacyPackages.${system};
    lum = pkgs.stdenvNoCC.mkDerivation {
      pname = "self-service-password";
      version = "1.5.4";
      src = self;
      installPhase = ''
        mkdir $out
        cp -r www/* $out/
      '';
    };
  in {
    packages = {
      ldap-user-manager = lum;
      default = lum;
    };
    devShells.php = pkgs.mkShell {
      packages = with pkgs; [
        php
      ];
    };
  });
}