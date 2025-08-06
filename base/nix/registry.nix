{ config, lib, pkgs, inputs, ... }:

{

  nix.registry = {

    nixpkgs-unstable = {
      from = {
        id = "nixpkgs-unstable";
        type = "indirect";
      };
      to = {
        type = "github";
        owner = "NixOS";
        repo = "nixpkgs";
        rev = inputs.nixpkgs-unstable.rev;
      };
    };

    qnixpkgs = {
      from = {
        id = "qnixpkgs";
        type = "indirect";
      };
      to = {
        type = "github";
        owner = "quyo";
        repo = "qnixpkgs";
        rev = inputs.qnixpkgs.rev;
      };
    };

  };

}
