{ config, lib, pkgs, qlib, hostname, ... }:

{

  quyo.net.fqdn = qlib.mkHostDefault "${hostname}.sky.quyo.net";

}
