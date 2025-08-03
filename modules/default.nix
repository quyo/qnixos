{ config, lib, pkgs, inputs, ... }:

{

  imports = [
    ./system-packages.nix
    inputs.qnixpkgs.nixosModules.userprofile
  ];

}
