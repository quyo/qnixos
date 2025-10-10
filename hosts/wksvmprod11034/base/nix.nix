{ config, lib, pkgs, ... }:

{

  nix = {
    distributedBuilds = lib.mkForce false;
    buildMachines     = lib.mkForce [ ];
    settings.builders = lib.mkForce "";
    settings.extra-substituters = lib.mkForce [
      "https://nix-community.cachix.org"
      "https://quyo-public.cachix.org"
    ];
  };

}
