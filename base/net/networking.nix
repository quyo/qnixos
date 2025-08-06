{ config, lib, pkgs, hostname, ... }:

{

  networking.hostName = hostname;

  networking.networkmanager.enable = true;

  networking.wireless.enable = false;

}
