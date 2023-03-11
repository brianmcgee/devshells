{
  system ? builtins.currentSystem,
  config ? {},
}:
(import ./. {inherit system config;}).devShell
