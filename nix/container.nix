{nixpkgs, self}:
  nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      self.nixosModules.default
      ./openldap.nix
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
}
 