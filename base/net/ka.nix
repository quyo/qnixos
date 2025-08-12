{ config, lib, pkgs, ... }:

{

  options.quyo.net.ka.ipv4.defaultGateway = lib.mkOption {
    type = lib.types.str;
    default = "192.168.73.173";
    example = "127.0.0.1";
    description = "Default gateway in KA";
  };

  options.quyo.net.ka.dns = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ "192.168.73.173" ];
    example = [ "127.0.0.1" ];
    description = "DNS servers in KA";
  };

}
