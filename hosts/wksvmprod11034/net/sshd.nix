{ config, lib, pkgs, secrets, hostname, ... }:

{

  services.openssh.enable = lib.mkForce false;

}
