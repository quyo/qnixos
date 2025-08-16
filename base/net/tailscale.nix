{ config, lib, pkgs, ... }:

{

  services.tailscale.enable = lib.mkOptionDefault true;

}
