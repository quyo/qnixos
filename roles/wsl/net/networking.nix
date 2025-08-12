{ config, lib, pkgs, hostname, ... }:

{

  networking.useDHCP = lib.mkForce true;

  wsl.wslConf.network.generateResolvConf = true;
  wsl.wslConf.network.generateHosts = true;

}
