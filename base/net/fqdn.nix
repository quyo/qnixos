{ config, lib, pkgs, hostname, ... }:

{

  options.quyo.net.fqdn = mkOption {
    type = types.str;
    default = "${hostname}.local";
    example = "foobar.local";
    description = "Fully qualified domain name (FQDN) of the host";
  };

}
