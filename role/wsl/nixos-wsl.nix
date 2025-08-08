{ config, lib, pkgs, inputs, ... }:

{

  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];

  wsl.enable = true;
  wsl.defaultUser = "johm";

}
