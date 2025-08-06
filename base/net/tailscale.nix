{ config, lib, pkgs, ... }:

{

  services.tailscale.enable = config.quyo.tailscale.enable;

}
