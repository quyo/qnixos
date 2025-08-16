{ config, lib, pkgs, ... }:

{

  # security.pam.services.sshd.allowNullPassword = true;
  # services.openssh = {
  #   enable = true;
  #   settings = {
  #     PermitRootLogin = lib.mkForce "yes";
  #     PasswordAuthentication = lib.mkForce true;
  #     PermitEmptyPasswords = lib.mkForce true;
  #   };
  # };

  # users.users.root.initialPassword = "";

}
