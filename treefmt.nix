{inputs, ...}: {
  perSystem = {
    pkgs,
    config,
    ...
  }: {
    # configure treefmt
    treefmt.config = {
      inherit (config.flake-root) projectRootFile;
      package = pkgs.treefmt;

      programs = {
        alejandra.enable = true;
      };
    };

    # allows us to run treefmt with `nix fmt`
    formatter = config.treefmt.build.wrapper;
  };
}
