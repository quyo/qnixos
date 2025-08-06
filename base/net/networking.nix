{ config, lib, pkgs, ... }:

{

  networking.hostName = config.quyo.host.name;

  networking.networkmanager.enable = true;

  # networking.wireless.enable = true;

}
