{ config, lib, pkgs, qlib, secrets, ... }:

{
  services.postfix.enable = lib.mkForce false;

}
