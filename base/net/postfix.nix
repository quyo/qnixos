{ config, lib, pkgs, ... }:

{

  services.postfix = {
    enable = true;
    hostname = config.quyo.host.fqdn;
    rootAlias = "johm@quyo.de";

    extraConfig = ''
      relayhost = [mx.quyo.net]:587
      smtp_tls_security_level = encrypt
      smtp_sasl_auth_enable = yes
      smtp_sasl_password_maps = ${config.quyo.postfix.sasl_password}
      smtp_sasl_security_options = noanonymous
    '';
  };

}
