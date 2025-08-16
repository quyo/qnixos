{ config, lib, pkgs, secrets, ... }:

{

  age.secrets.base-nix-netrc = {
    file = "${secrets}/secrets/base/nix/netrc.age";
    owner = "root";
    group = "root";
    mode  = "0400";
  };

  nix.settings.netrc-file = config.age.secrets.base-nix-netrc.path;

}
