{ config, lib, pkgs, hostname, ... }:

{

  options.quyo.net.fqdn = lib.mkOption {
    type = lib.types.str;
    default = "${hostname}.local";
    example = "foobar.local";
    description = "Fully qualified domain name (FQDN) of the host";
  };

}
