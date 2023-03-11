args @ {
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.languages.java;
in {
  options = import ./types.nix args;

  config = with lib;
    mkIf cfg.enable {
      devshell = {
        packages = with pkgs; [
            cfg.jdk.package
            cfg.gradle.package
        ];

        env = [
          {
            name = "JAVA_HOME";
            value = pkgs.${cfg.jdk.package}.home;
          }
        ];
      };
    };
}
