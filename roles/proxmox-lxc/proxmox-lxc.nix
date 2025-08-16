{ config, lib, pkgs, modulesPath, ... }:

{

  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  proxmoxLXC = {
    privileged = false;
    manageNetwork = false;
  };

}
