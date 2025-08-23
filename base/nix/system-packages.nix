{ config, lib, pkgs, inputs, system, pkgs-stable, pkgs-unstable, qpkgs, ... }:

{

  environment.systemPackages = with pkgs; [
  ] ++ [
    qpkgs.userprofile
    inputs.agenix.packages.${system}.default
  ];

  imports = [
    inputs.qnixpkgs.nixosModules.userprofile
  ];

}
