{
  lib,
  pkgs,
  ...
}: {
  languages.java = with lib; {
    enable = mkEnableOption (mdDoc "Enable java language support");

    jdk.package = mkOption {
      type = types.str;
      default = "jdk"; # todo look at strOrPackage in devshell
      description = mdDoc "Jdk to use";
    };

    gradle.package = mkOption {
      type = types.str;
      default = "gradle";
      description = mdDoc "Gradle to use";
    };
  };
}
