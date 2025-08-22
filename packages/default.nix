{ inputs }:

let
  systems = [ "x86_64-linux" "aarch64-linux" ];
  forAllSystems = f: inputs.nixpkgs.lib.genAttrs systems (system: f system);
in
  forAllSystems (system:
  {
    proxmox-lxc-template = import ./proxmox-lxc-template.nix { inherit inputs system; };
  })
