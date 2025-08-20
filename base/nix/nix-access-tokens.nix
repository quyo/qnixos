{ config, lib, pkgs, secrets, ... }:

{

  age.secrets.base-nix-access-tokens = {
    file = "${secrets}/secrets/base/nix/nix-access-tokens.age";
    owner = "johm";
    group = "users";
    mode  = "0400";
  };

  nix.extraOptions = ''
    !include ${config.age.secrets.base-nix-access-tokens.path}
  '';

}
