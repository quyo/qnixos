{ config, lib, pkgs, inputs, system, pkgs-stable, pkgs-unstable, qpkgs, ... }:

{

  nixpkgs.hostPlatform = system;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays =
    let
      overlay = final: prev: {
        inherit pkgs-stable pkgs-unstable qpkgs;
      };
    in
      [ overlay ];

  # Use the system nixpkgs for nix commands
  # https://www.zknotes.com/page/use%20the%20system%20nixpkgs%20for%20nix%20commands

}
