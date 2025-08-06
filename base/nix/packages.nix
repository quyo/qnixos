{ config, lib, pkgs, inputs, ... }:

{

  environment.systemPackages = with pkgs; [
    qnixpkgs.userprofile
  ];

  imports = [
    inputs.qnixpkgs.nixosModules.userprofile
  ];

}
