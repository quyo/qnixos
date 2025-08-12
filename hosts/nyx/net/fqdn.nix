{ config, lib, pkgs, hostname, ... }:

{

  quyo.net.fqdn = lib.mkForce "${hostname}.sky.quyo.net";

}
