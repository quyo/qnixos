{ config, lib, pkgs, hostname, ... }:

{

  networking.hostName = hostname;

  networking.useDHCP = false;
  networking.interfaces = {};
  networking.defaultGateway = null;
  networking.nameservers = [];

  networking.wireless.enable = false;

  networking.networkmanager.enable = false;
  systemd.network.enable = false;
  services.resolved.enable = false;

  # global fallback DNS in case the link DNS does not respond
  services.resolved.fallbackDns = [

    # IPv4
    "9.9.9.9"
    "1.1.1.1"

    # IPv6
    "2620:fe::fe"
    "2606:4700:4700::1111"

  ];
  services.resolved.dnssec = "allow-downgrade";

}
