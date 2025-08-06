{ config, lib, pkgs, inputs, system, ... }:

let

  overlay-unstable = final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  };

  overlay-qnixpkgs = final: prev: {
    qnixpkgs = inputs.qnixpkgs.packages.${system};
  };

in
{

  nixpkgs.overlays = [ overlay-unstable overlay-qnixpkgs ];

}
