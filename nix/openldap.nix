{ config, pkgs, ... }:
{
  services.openldap = {
    enable = true;
    urlList = [ "ldap:///" ];
    settings = {
      attrs = {
        #olcLogLevel = [ "-1" ];
        #olcLogLevel = [ "ACL" ];
        olcLogLevel = [ ];
      };
      children = {
        "cn=schema" = {
          includes = [
            "${pkgs.openldap}/etc/schema/core.ldif"
            "${pkgs.openldap}/etc/schema/cosine.ldif"
            "${pkgs.openldap}/etc/schema/inetorgperson.ldif"
            "${pkgs.openldap}/etc/schema/nis.ldif"
          ];
        };
        "olcDatabase={-1}frontend" = {
          attrs = {
            objectClass = "olcDatabaseConfig";
            olcDatabase = "{-1}frontend";
            olcAccess = [
              "to dn.base=\"\" by * read"
              "to dn.base=cn=subschema by * read"
              "to * by * none"
            ];
          };
        };
        "olcDatabase={1}mdb" = {
          attrs = {
            objectClass = [ "olcDatabaseConfig" "olcMdbConfig" ];
            olcDatabase = "{1}mdb";
            olcDbDirectory = "/var/lib/openldap/db";
            olcSuffix = "dc=example,dc=org";
            olcRootDn = "cn=admin,dc=example,dc=org";
            olcRootPw = "{SSHA}0zY687a4lDfBmjxzQRAWdlKkAW0UwyWE"; #slappasswd -s <secret> test123
            olcAccess = [
              #allow login for apps. roles are: reader, writer
              "{0}to dn.one=ou=roles,dc=example,dc=org by anonymous auth" #authentification as role
              #access to users
              ''{1}to dn.subtree=ou=users,dc=example,dc=org
                by self write
                by anonymous auth
              ''
              # searching
              "{3} to dn.subtree=dc=example,dc=org by users read"
             ];
          };
        };
      };
    };
    declarativeContents = {
      "dc=example,dc=org" = ''
        dn: dc=example,dc=org
        objectClass: domain
        dc: example

        dn: ou=users,dc=example,dc=org
        objectClass: organizationalUnit
        ou: users

        dn: uid=user1,ou=users,dc=example,dc=org
        objectClass: person
        objectClass: inetOrgPerson
        cn: Bob User
        givenName: Bob
        mail: bob@pendor.de
        sn: User
        uid: user1
        userPassword: {SSHA}0zY687a4lDfBmjxzQRAWdlKkAW0UwyWE
      '';
    };
  };
  users.groups.ldapreader = {};
}

