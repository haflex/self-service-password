{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs;
    flake-utils.url = github:numtide/flake-utils;
  };

  description = "self-service-password";

  outputs = { self, nixpkgs, flake-utils }:
  flake-utils.lib.eachDefaultSystem (system: let pkgs = nixpkgs.legacyPackages.${system}; in
    let
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
    }
  ) // {
    nixosModules.default = { config, pkgs, lib, ...}: with lib; let
      cfg = config.services.self-service-password;
    in {
      options.services.self-service-password = {
        enable = mkEnableOption "Enables the self service password service";
      };
      config = mkIf cfg.enable {
        services.phpfpm.pools.ssp = let
          configFile = "Hallo";
        in {
          user = "ssp";
          phpEnv = {
            SSP_CONFIG_FILE = configFile;
          };
          settings = {
            "listen.owner" = config.services.nginx.user;
            "pm" = "dynamic";
            "pm.max_children" = 32;
            "pm.max_requests" = 500;
            "pm.start_servers" = 2;
            "pm.min_spare_servers" = 2;
            "pm.max_spare_servers" = 5;
            "php_admin_value[error_log]" = "syslog";
            "php_admin_flag[log_errors]" = true;
            "catch_workers_output" = true;
          };
        };
        services.nginx.virtualHosts.ssp = {
          #serverName = "speck"; #cfg.hostName;
          root = "${self.packages.x86_64-linux.ssp}/share/php/self-service-password/htdocs";
          locations = {
            "/" = { index = "index.php"; };
            "~ \.php$" = { extraConfig = ''
                fastcgi_pass unix:${config.services.phpfpm.pools.ssp.socket};
            '';};
          };
        };
        users.users.ssp = {
          isSystemUser = true;
          group = "ssp";
        };
        users.groups.ssp = {};
      };
    };
    nixosConfigurations.container = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        self.nixosModules.default
        ({config, ...}: {
          services.self-service-password.enable = true;
          boot.isContainer = true;
          networking.hostName = "speck";
          services.nginx.enable = true;
          networking.firewall.allowedTCPPorts = [ 80 ];
          system.stateVersion = "23.11";
        })
      ];
    };
  };
}