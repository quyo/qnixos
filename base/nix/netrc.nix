{ config, lib, pkgs, secrets, ... }:

{

  age.secrets.nix-netrc = {
    file = "${secrets}/nix-netrc.age";
    owner = "root";
    group = "root";
    mode  = "0400";
  };

  nix.settings.netrc-file = config.age.secrets.nix-netrc.path;

}
