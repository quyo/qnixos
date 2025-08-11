{ config, lib, pkgs, inputs, system, ... }:

{

  environment.systemPackages = with pkgs; [
    qnixpkgs.userprofile
    inputs.agenix.packages.${system}.default
  ];

  imports = [
    inputs.qnixpkgs.nixosModules.userprofile
  ];

}
