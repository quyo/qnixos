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
    mkBaseDefault = lib.mkOverride 1250;
    mkRoleDefault = lib.mkDefault;
    mkHostDefault = lib.mkForce;

    relativeToRoot = lib.path.append ./.;
  };
}
