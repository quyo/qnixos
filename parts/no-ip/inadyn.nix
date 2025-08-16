{ config, lib, pkgs, secrets, ... }:

{

  age.secrets.parts-noip-inadyn-provider-noip = {
    file = "${secrets}/secrets/parts/no-ip/inadyn-provider-noip.age";
    owner = "inadyn";
    group = "inadyn";
    mode  = "0400";
  };

  services.inadyn = {
    enable = true;
    settings = {
      period = 300;            # alle 300s externe IP prüfen
      forced-update = 2592000; # alle 30 Tage Update erzwingen
      allow-ipv6 = true;

      provider."no-ip.com" = {
        include  = config.age.secrets.parts-noip-inadyn-provider-noip.path;
        hostname = [ "all.ddnskey.com" ];
        checkip-command = "${pkgs.curl}/bin/curl -4 -s https://api.ipify.org";
        ssl = true;
      };

      provider."no-ip.com:v6" = {
        include  = config.age.secrets.parts-noip-inadyn-provider-noip.path;
        hostname = [ "all.ddnskey.com" ];
        checkip-command = "${pkgs.curl}/bin/curl -6 -s https://api64.ipify.org";
        ssl = true;
      };
    };
  };

}
