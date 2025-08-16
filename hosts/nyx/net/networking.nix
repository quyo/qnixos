{ config, lib, pkgs, qlib, ... }:

let
  iface = "ens18";
in
{

  systemd.network.enable = qlib.mkHostDefault true;
  services.resolved.enable = qlib.mkHostDefault true;

  systemd.network.networks."10-${iface}" = {
    matchConfig.Name = [ iface ];

    networkConfig = {
      Address = [ "192.168.72.100/23" ];

      DHCP = "ipv6";                   # GUA via DHCPv6
      IPv6AcceptRA = true;             # SLAAC
      LinkLocalAddressing = "ipv6";
      IPv6PrivacyExtensions = "yes";   # optional: privacy extensions (prefer temporary v6 addresses)

      DNS = config.quyo.net.ka.dns;
    };

    routes = [
      {
        Destination = "0.0.0.0/0";
        Gateway = config.quyo.net.ka.ipv4.defaultGateway;
      }
    ];

    # wait until interface is "routable" (more stable boot behaviour)
    linkConfig.RequiredForOnline = "routable";
  };

}
