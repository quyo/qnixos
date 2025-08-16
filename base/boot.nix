{ config, lib, pkgs, ... }:

{

  boot.loader.grub.enable = lib.mkOptionDefault true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.configurationLimit = 10;

}
