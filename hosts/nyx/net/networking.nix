{ config, lib, pkgs, ... }:

{

  systemd.network.enable = lib.mkForce true;
  services.resolved.enable = lib.mkForce true;

  networking.interfaces.ens18.ipv4.addresses = [
    { address = "192.168.72.100"; prefixLength = 23; }
  ];

  networking.defaultGateway = config.quyo.net.ka.defaultGateway;
  networking.nameservers = config.quyo.net.ka.nameservers;

}
