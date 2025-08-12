{ config, lib, pkgs, ... }:

{

  services.tailscale.enable = lib.mkForce false;

}
