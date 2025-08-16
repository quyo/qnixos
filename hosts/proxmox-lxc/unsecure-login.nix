{ config, lib, pkgs, qlib, ... }:

{

  # security.pam.services.sshd.allowNullPassword = true;
  # services.openssh = {
  #   enable = true;
  #   settings = {
  #     PermitRootLogin = qlib.mkHostDefault "yes";
  #     PasswordAuthentication = qlib.mkHostDefault true;
  #     PermitEmptyPasswords = qlib.mkHostDefault true;
  #   };
  # };

  # users.users.root.initialPassword = "";

}
