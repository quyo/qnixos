{ config, lib, pkgs, ... }:

{

  options.quyo.net.ka.defaultGateway = lib.mkOption {
    type = lib.types.str;
    default = "192.168.73.173";
    example = "127.0.0.1";
    description = "Default gateway in KA";
  };

  options.quyo.net.ka.nameservers = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ "192.168.73.173" ];
    example = [ "127.0.0.1" ];
    description = "DNS servers in KA";
  };

}
