{ config, lib, pkgs, ... }:

{

  boot.loader.grub.enable = lib.mkForce false;

}
