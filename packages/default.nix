{ inputs }:

let
  system = "x86_64-linux";
in
{
  ${system}.proxmox-lxc-template = import ./proxmox-lxc-template.nix { inherit inputs system; };
}
