{ config, lib, pkgs, inputs, ... }:

{

  nix.registry = {

    nixpkgs.flake = inputs.nixpkgs;
    nixpkgs-unstable.flake = inputs.nixpkgs-unstable;
    qnixpkgs.flake = inputs.qnixpkgs;

  };

}
