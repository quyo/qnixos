{ config, lib, pkgs, qlib, ... }:

{

  boot.loader.grub.enable = qlib.mkBaseDefault true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.configurationLimit = 10;

}
