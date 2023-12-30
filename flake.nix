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
        patchPhase = ''
          sed -i 's|define("SMARTY".*|define("SMARTY", "${pkgs.smarty3}/Smarty.class.php");|' conf/config.inc.php
        '';
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
        keyphraseFile = mkOption rec {
          type = types.str;
          default = "/var/keys/sspSecret";
          example = default;
          description = "file containing the secret key for generating password reset tokens";
        };
        dataDir = mkOption rec {
          type = types.str; #TODO types.path?
          default = "/var/lib/self-service-password";
          example = default;
          description = "state directory for self service password";
        };
      };
      config = mkIf cfg.enable {
        services.phpfpm.pools.ssp = let
          configFile = pkgs.writeText "sspConfig" ''
            <?php
            $keyphrase = get_file_contents("${cfg.keyphraseFile}");
            $audit_log_file = "${cfg.dataDir}/audit.log";
            ?>
          '';
        in {
          user = "ssp";
          phpEnv = {
            SSP_CONFIG_FILE = toString configFile;
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
        systemd.services.ssp-setup = {
            script = ''
              # prepare dataDir
              if [ ! -f ${cfg.dataDir} ]; then
                mkdir -p ${cfg.dataDir}
              fi
            '';
            wantedBy = [ "phpfpm-ssp.service" ];
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
          services.self-service-password = {
            enable = true;
          };
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