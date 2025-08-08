{ config, lib, pkgs, ... }:

{

  services.postfix.enable = lib.mkForce false;

}
