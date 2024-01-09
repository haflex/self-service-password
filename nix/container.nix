{nixpkgs, self}:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    self.nixosModules.default
    ./openldap.nix
    ({config, pkgs, ...}: {
      services.self-service-password = {
        enable = true;
        ldap = {
          bindDN = "cn=admin,dc=example,dc=org";
          base = "ou=users,dc=example,dc=org";
        };
        email = {
          from = "noone@localhost";
          smtp = {
            host = "localhost";
            port = 1025;
            debug = 3;
            secure = "";
          };
        };
        resetUrl = "http://ssp/";
      };
      boot.isContainer = true;
      networking.hostName = "speck";
      services.nginx.enable = true;
      networking.firewall.allowedTCPPorts = [ 80 8025];
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      nix.registry.os.flake = nixpkgs;
      system.stateVersion = "23.11";
      environment.systemPackages = with pkgs; [
        shelldap
        mailpit
      ];
    })
  ];
}
 