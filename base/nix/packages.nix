{ config, lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    qnixpkgs.userprofile
  ];

  imports = [
    inputs.qnixpkgs.nixosModules.userprofile
  ];

}
