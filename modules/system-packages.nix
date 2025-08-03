{ config, lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    qnixpkgs.userprofile
  ];

}
