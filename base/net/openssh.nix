{ config, lib, pkgs, ... }:

{

  services.openssh = {
    enable = true;
    allowSFTP = false;

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

}
