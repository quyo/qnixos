{ config, lib, pkgs, secrets, hostname, ... }:

{

  age.secrets.hosts-ssh-ssh_host_ed25519_key = {
    file = "${secrets}/secrets/hosts/${hostname}/ssh/ssh_host_ed25519_key.age";
    path = "/etc/ssh/ssh_host_ed25519_key";
    symlink = false;
    owner = "root";
    group = "root";
    mode = "0600";
  };

  services.openssh = {
    enable = true;

    hostKeys = [
      {
        path = config.age.secrets.hosts-ssh-ssh_host_ed25519_key.path;
        type = "ed25519";
      }
    ];

    settings = {
      PermitRootLogin = "no";
      AllowUsers = [ "johm" ];

      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      ChallengeResponseAuthentication = false;

      MaxAuthTries = 3;
      MaxSessions = 5;
    };
  };

  systemd.services.sshd = {
    preStart = ''
      install -d -m0755 -o root -g root /etc/ssh
      if [ -s "${config.age.secrets.hosts-ssh-ssh_host_ed25519_key.path}" ]; then
        ssh-keygen -y -f "${config.age.secrets.hosts-ssh-ssh_host_ed25519_key.path}" > /etc/ssh/ssh_host_ed25519_key.pub
        chmod 0644 /etc/ssh/ssh_host_ed25519_key.pub
      fi
    '';
  };

}
