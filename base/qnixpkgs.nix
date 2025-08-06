{ config, lib, pkgs, inputs, ... }:

{

  imports = [
    inputs.qnixpkgs.nixosModules.userprofile
  ];

}
