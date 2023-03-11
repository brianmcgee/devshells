{
  lib,
  pkgs,
  ...
}: {
  languages.go = with lib; {
    enable = mkEnableOption (mdDoc "Enable go language support");

    package = mkOption {
      type = types.str; # todo look at strOrPackage in devshell
      default = "go";
      description = mdDoc "Go package to use";
    };
  };
}
