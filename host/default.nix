{ lib }:

let
  modules = builtins.mapAttrs
    (name: type: import ./${name})
    (lib.filterAttrs
      (name: type: type == "directory")
      (builtins.readDir ./.)
    );
in

modules
