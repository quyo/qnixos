{ config, lib, pkgs, ... }:

{

  services.timesyncd.enable = lib.mkForce false;

}
