{ inputs }:
specialArgs@{ ... }:

let
  system = specialArgs.system;

  pkgs-stable = import inputs.nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };

  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };

  qpkgs = inputs.qnixpkgs.packages.${system};
in

specialArgs
//
{
  inherit inputs pkgs-stable pkgs-unstable qpkgs;
  secrets = inputs.qnixos-secrets;
  qlib =
    let
      lib = inputs.qnixpkgs.nixpkgs-stable.${system}.lib;
    in
      lib.q
      //
      {
        mkBaseDefault = lib.mkOverride 1250;
        mkRoleDefault = lib.mkDefault;
        mkHostDefault = lib.mkForce;

        relativeToRoot = lib.path.append ./.;
      };
}
