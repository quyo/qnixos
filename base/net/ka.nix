{ config, lib, pkgs, ... }:

{

  options.quyo.net.ka.defaultGateway = mkOption {
    type = types.str;
    default = "192.168.73.173";
    example = "127.0.0.1";
    description = "Default gateway in KA";
  };

  options.quyo.net.ka.nameservers = mkOption {
    type = types.listOf types.str;
    default = [ "192.168.73.173" ];
    example = [ "127.0.0.1" ];
    description = "DNS servers in KA";
  };

}
