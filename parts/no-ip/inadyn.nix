{ config, lib, pkgs, secrets, ... }:

{

  age.secrets.inadyn-provider-noip = {
    file = "${secrets}/inadyn-provider-noip.age";
    owner = "inadyn";
    group = "inadyn";
    mode  = "0400";
  };

  services.inadyn = {
    enable = true;
    settings = {
      period = 300;            # alle 300s externe IP prüfen
      forced-update = 2592000; # alle 30 Tage Update erzwingen

      provider."no-ip.com".include = config.age.secrets.inadyn-provider-noip.path;
      provider."no-ip.com" = {
        hostname = [ "all.ddnskey.com" ];
        # optional:
        # checkip-server = "ifconfig.me";
        # checkip-ssl = true;
      };
    };
  };

}
