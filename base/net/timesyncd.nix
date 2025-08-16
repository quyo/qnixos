{ config, lib, pkgs, qlib, ... }:

{

  services.timesyncd = {
    enable = qlib.mkBaseDefault true;

    servers = [
      "0.de.pool.ntp.org"
      "1.de.pool.ntp.org"
      "2.de.pool.ntp.org"
      "3.de.pool.ntp.org"
      # "ptbtime1.ptb.de"
      # "ptbtime2.ptb.de"
      # "ptbtime3.ptb.de"
    ];

    fallbackServers = [
      "0.europe.pool.ntp.org"
      "1.europe.pool.ntp.org"
      "2.europe.pool.ntp.org"
      "3.europe.pool.ntp.org"
    ];
  };

}
