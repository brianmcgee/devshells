args @ {
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.languages.go;
  goPkg = pkgs.${cfg.package};
in {
  options = import ./types.nix args;

  config = with lib;
    mkIf cfg.enable {
      devshell = {
        packages = with pkgs; [
          goPkg
          delve
        ];

        env = [
          {
            name = "GOROOT";
            value = goPkg + "/share/go";
          }
        ];
      };
    };
}
