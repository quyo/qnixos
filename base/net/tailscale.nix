{ config, lib, pkgs, qlib, ... }:

{

  services.tailscale.enable = qlib.mkBaseDefault true;

}
