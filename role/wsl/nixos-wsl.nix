{ config, lib, pkgs, inputs, hostname, ... }:

{

  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];

  wsl.enable = true;
  wsl.defaultUser = "johm";

  networking.hostName = hostname;

}
