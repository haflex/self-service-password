{ config, pkgs, lib, ssp, ...}:
with lib;
let
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
    host = mkOption {
      type = types.nullOr types.str;
      default = null;
      example = "ssp.example.com";
      description = "hostname of the server";
    };
    ldap = {
      url = mkOption {
        type = types.str;
        default = "ldap://localhost";
        example = "ldap://localhost";
        description = "hostname of the LDAP server to connect to";
      };
      starttls = mkOption {
        type = types.bool;
        default = false;
        example = false;
        description = "if to use TLS";
      };
      bindDN = mkOption {
        type = types.str;
        example = "cn=admin,dc=example,dc=com";
        description = "DN to access the LDAP server";
      };
      bindPassFile = mkOption {
        type = types.str;
        default = "/var/keys/sspBindPass";
        example = "/var/keys/sspBindPass";
        description = "file with password to bind LDAP server";
      };
      base = mkOption {
        type = types.str;
        example = "ou=users,dc=example,dc=org";
        description = "base DN inside the LDAP server";
      };
      loginAttribute = mkOption {
        type = types.str;
        default = "uid";
        example = "uid";
        description = "attribute to identify the login key";
      };
      fullnameAttribute = mkOption {
        type = types.str;
        default = "cn";
        example = "cn";
        description = "attribute to identify the users full name";
      };
      searchFilter = mkOption {
        type = types.str;
        default = "(&(objectClass=person)(uid={login}))";
        example = "(&(objectClass=person)(uid={login}))";
        description = "filter used when finding user";
      };
      hash = mkOption {
        type = types.str;
        default = "SSHA";
        example = "CRYPT";
        description = "hash algorithm used to store the password";
      };
    };
    email = {
      ldapAttribute = mkOption {
        type = types.str;
        default = "mail";
        example = "proxyAddresses";
        description = "attribute to identify the users email address";
      };
      from = mkOption {
        type = types.str;
        example = "admin@example.com";
        description = "email address to send emails from";
      };
      fromName = mkOption {
        type = types.str;
        default = "Self Service Password";
        example = "Self Service Password";
        description = "name to send emails from";
      };
      smtp = {
        host = mkOption {
          type = types.str;
          default = "localhost";
          example = "localhost";
          description = "hostname of the SMTP server to connect to";
        };
        port = mkOption {
          type = types.int;
          default = 25;
          example = 25;
          description = "port of the SMTP server to connect to";
        };
        user = mkOption {
          type = types.str;
          default = "";
          example = "admin";
          description = "username to authenticate with the SMTP server";
        };
        passFile = mkOption {
          type = types.str;
          default = "";
          example = "/var/key/sspSmtpPass";
          description = "password to authenticate with the SMTP server";
        };
        auth = mkOption {
          type = types.bool;
          default = false;
          description = "if to use authentication with the SMTP server";
        };
        debug = mkOption {
          type = types.int;
          default = 0;
          description = "debug flags, see: https://github.com/PHPMailer/PHPMailer/wiki/Troubleshooting";
        };
        secure = mkOption {
          type = types.str;
          default = "tls";
          example = "ssl";
          description = "security method to use. Either tls or ssl";
        };
      };
    };
    resetUrl = mkOption {
      type = types.str;
      example = "https://localhost/reset.php";
      description = "URL to the reset page";
    };
  };
  config = mkIf cfg.enable {
    services.phpfpm.pools.ssp = let
      configFile = pkgs.writeText "sspConfig" ''
        <?php
        $keyphrase = file_get_contents("${cfg.keyphraseFile}");
        $audit_log_file = "${cfg.dataDir}/audit.log";
        // Cache directory
        $smarty_compile_dir = "${cfg.dataDir}/templates_c";
        $smarty_cache_dir = "${cfg.dataDir}/cache";
        // disable sms and question interface
        $use_sms = false;
        $use_questions = false;
        $use_change = false;
        //setup LDAP
        $ldap_url = "${cfg.ldap.url}";
        $ldap_starttls = ${if cfg.ldap.starttls then "true" else "false"};
        $ldap_binddn = "${cfg.ldap.bindDN}";
        $ldap_bindpw = trim(file_get_contents("${cfg.ldap.bindPassFile}"));
        $ldap_base = "${cfg.ldap.base}";
        $ldap_login_attribute = "${cfg.ldap.loginAttribute}";
        $ldap_fullname_attribute = "${cfg.ldap.fullnameAttribute}";
        $ldap_filter = "${cfg.ldap.searchFilter}";
        $ldap_network_timeout = 5;
        $ldap_krb5ccname = NULL;
        $hash = "${cfg.ldap.hash}";
        //setup email
        $mail_attributes = array( "${cfg.email.ldapAttribute}" );
        $mail_from = "${cfg.email.from}";
        $mail_from_name = "${cfg.email.fromName}";
        $mail_smtp_host = '${cfg.email.smtp.host}';
        $mail_smtp_auth = ${if cfg.email.smtp.auth then "true" else "false"};
        $mail_smtp_user = '${cfg.email.smtp.user}';
        $mail_smtp_pass = "";
        $mail_smtp_port = ${toString cfg.email.smtp.port};
        $mail_smtp_debug = ${toString cfg.email.smtp.debug};
        $mail_smtp_secure = "${cfg.email.smtp.secure}";
        //url generation
        $reset_url = "${cfg.resetUrl}";
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
        chown ssp:ssp ${cfg.dataDir}
        chmod 775 ${cfg.dataDir}
        fi
        # create secret
        if [ ! -f ${cfg.keyphraseFile} ]; then
        mkdir -p $(dirname ${cfg.keyphraseFile})
        head /dev/urandom | tr -dc A-Za-z0-9 | head -c10 > ${cfg.keyphraseFile}
        chown ssp:ssp ${cfg.keyphraseFile}
        chmod 440 ${cfg.keyphraseFile}
        fi
      '';
      wantedBy = [ "phpfpm-ssp.service" ];
    };
    services.nginx.virtualHosts.ssp = {
      serverName = cfg.host;
      root = "${ssp}/share/php/self-service-password/htdocs";
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
}