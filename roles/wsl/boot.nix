{ config, lib, pkgs, ... }:

{

  boot.loader.grub.enable = false;

  wsl.wslConf.boot.systemd = true;

}
