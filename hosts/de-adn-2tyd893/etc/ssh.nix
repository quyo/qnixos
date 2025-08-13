{ config, lib, pkgs, ... }:

{

  programs.ssh.extraConfig = lib.mkBefore ''

    Host sky
      User johm
      HostName sky.quyo.net

    Host nyx
      User johm
      HostName nyx.sky.quyo.net

  '';

}
