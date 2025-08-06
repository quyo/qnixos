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

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ overlay-unstable overlay-qnixpkgs ];

  # Use the system nixpkgs for nix commands
  # https://www.zknotes.com/page/use%20the%20system%20nixpkgs%20for%20nix%20commands

}
