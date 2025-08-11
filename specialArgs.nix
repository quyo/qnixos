{ inputs }:
specialArgs@{ ... }:

let
  lib = inputs.qnixpkgs.nixpkgs-stable.${specialArgs.system}.lib;
in

specialArgs
//
{
  inherit inputs;
  secrets = inputs.qnixos-secrets;
  qlib = lib.q
  //
  {
    relativeToRoot = lib.path.append ./.;
  };
}
