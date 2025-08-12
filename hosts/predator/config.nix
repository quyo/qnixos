{ config, lib, pkgs, hostname, ... }:

{

  options.quyo = lib.mkOption {
    type = lib.types.attrs;
    default = {};
  };

  config.quyo = {
    fqdn = "${hostname}.local";
  };

}
