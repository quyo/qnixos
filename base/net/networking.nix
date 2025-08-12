{ config, lib, pkgs, hostname, ... }:

{

  networking.hostName = hostname;

  networking.useDHCP = false;

  networking.wireless.enable = false;

  networking.networkmanager.enable = false;
  systemd.network.enable = false;
  services.resolved.enable = false;

}
