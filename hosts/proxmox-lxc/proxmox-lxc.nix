{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
  ];

  proxmoxLXC = {
    privileged = true;
    manageNetwork = false;  # Netz kommt von Proxmox (pct/GUI)
  };
}
