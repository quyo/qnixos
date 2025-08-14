{ config, lib, pkgs, ... }:

{

  services.openssh = {
    enable = true;

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
