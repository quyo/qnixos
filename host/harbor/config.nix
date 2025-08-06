{ config, lib, pkgs, ... }:

{

  options.quyo = lib.mkOption {
    type = lib.types.attrs;
    default = {};
  };

  config.quyo = {
    host = rec {
      name = "harbor";
      fqdn = "${name}.sky.quyo.net";
    };
    tailscale.enable = true;
  };

  config.networking = {
    useDHCP = false;

    interfaces.ens18 = {
      ipv4.addresses = [{
        address = "192.168.72.101";
        prefixLength = 23;
      }];
    };

    defaultGateway = "192.168.73.173";
    nameservers = [ "192.168.73.173" ];
  };

}
