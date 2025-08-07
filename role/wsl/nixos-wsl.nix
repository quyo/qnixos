{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.nixos-wsl.nixosModules.default
  ];
}
