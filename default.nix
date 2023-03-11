args @ {
  system ? builtins.currentSystem,
  inputs ? import ./flake.lock.nix {},
  overlays ? [],
  pkgs ?
    import inputs.nixpkgs {
      inherit system overlays;
      # Makes the config pure as well. See <nixpkgs>/top-level/impure.nix:
      config = {};
    },
  devshell ?
    import inputs.devshell {
      inherit system;
    },
  config ? {},
}: let
  lib = pkgs.lib;

  eval = lib.evalModules {
    modules = [
      {
        options.devshell = with lib;
          mkOption {
            description = mdDoc "The devshell to expose";
            type = types.submoduleWith {
              modules = import (inputs.devshell + "/modules/modules.nix") {inherit lib pkgs;};
              specialArgs = {inherit lib pkgs;};
            };
          };
      }
      ./languages
      {
        inherit config;
      }
    ];
    specialArgs = {inherit lib pkgs;};
  };
in {
  devShell = eval.config.devshell.devshell.shell;
}
