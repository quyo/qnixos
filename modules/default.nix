{ inputs }:

{ config, lib, pkgs, ... }:

let

  overlay-unstable = final: prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = prev.system;
      config.allowUnfree = true;
    };
  };

  overlay-qnixpkgs = final: prev: {
    qnixpkgs = inputs.qnixpkgs.packages.${prev.system};
  };

in
{

  nixpkgs.overlays = [ overlay-unstable overlay-qnixpkgs ];

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

  imports = [
    inputs.qnixpkgs.nixosModules.userprofile
  ] ++ [
    ./qos-base.nix
    ./qos-desktop.nix
    ./qos-network.nix
    ./qos-nixos.nix
    ./qos-service.nix
    ./qos-user.nix
  ];

}
