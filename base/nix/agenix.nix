{ config, lib, pkgs, inputs, ... }:

{

  imports = [
    inputs.agenix.nixosModules.default
  ];

  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" "/etc/ssh/ssh_bootstrap_ed25519_key" ];

}
