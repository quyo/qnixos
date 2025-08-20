{ config, lib, pkgs, secrets, hostname, ... }:

{

  age.secrets.hosts-ssh-ssh_root_ed25519_key = {
    file = "${secrets}/secrets/hosts/${hostname}/ssh/ssh_root_ed25519_key.age";
    owner = "root";
    group = "root";
    mode = "0600";
  };

  age.secrets.hosts-ssh-ssh_johm_ed25519_key = {
    file = "${secrets}/secrets/hosts/${hostname}/ssh/ssh_johm_ed25519_key.age";
    owner = "johm";
    group = "users";
    mode = "0600";
  };

  programs.ssh.extraConfig = lib.mkAfter ''
    Match localuser root
      IdentityFile ${config.age.secrets.hosts-ssh-ssh_root_ed25519_key.path}

    Match localuser johm
      IdentityFile ${config.age.secrets.hosts-ssh-ssh_johm_ed25519_key.path}

    Match all
  '';

}
