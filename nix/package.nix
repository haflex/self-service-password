{self, buildComposerProject, smarty3}:
buildComposerProject {
  pname = "self-service-password";
  src = self;
  version = "1.6.0";
  vendorHash = "sha256-kOO8E0+mYtq7WqkPpYtfRCvEBu+Z25uPD5uNrJqZ+/c=";
  patchPhase = ''
    sed -i 's|define("SMARTY".*|define("SMARTY", "${smarty3}/Smarty.class.php");|' conf/config.inc.php
  '';
}