{ config, lib, pkgs, hostname, ... }:

{

  networking.useDHCP = true;

  wsl.wslConf.network.generateResolvConf = true;
  wsl.wslConf.network.generateHosts = true;

}
