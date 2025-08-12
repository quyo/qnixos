{ config, lib, pkgs, ... }:

{

  systemd.network.enable = true;
  services.resolved.enable = true;

  networking.interfaces.ens18.ipv4.addresses = [
    { address = "192.168.72.101"; prefixLength = 23; }
  ];

  networking.defaultGateway = config.quyo.net.ka.defaultGateway;
  networking.nameservers = config.quyo.net.ka.nameservers;

}
