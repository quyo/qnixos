{ inputs, system }:

let
  nixos-generators = inputs.nixos-generators;
  extendSpecialArgs = inputs.self.outputs.extendSpecialArgs;
  nixosModules = inputs.self.outputs.nixosModules;
in
  nixos-generators.nixosGenerate {
    inherit system;
    format = "proxmox-lxc";

    specialArgs = extendSpecialArgs { inherit system; hostname = "proxmox-lxc"; };

    modules = [
      nixosModules.proxmox-lxc
    ];
  }
