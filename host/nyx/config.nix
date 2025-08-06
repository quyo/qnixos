{ config, lib, pkgs, hostname, ... }:

{

  options.quyo = lib.mkOption {
    type = lib.types.attrs;
    default = {};
  };

  config.quyo = {
    fqdn = "${hostname}.sky.quyo.net";
  };

  config.networking = {
    useDHCP = false;

    interfaces.ens18 = {
      ipv4.addresses = [{
        address = "192.168.72.100";
        prefixLength = 23;
      }];
    };

    defaultGateway = "192.168.73.173";
    nameservers = [ "192.168.73.173" ];
  };

}
