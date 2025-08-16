{ config, lib, pkgs, qlib, secrets, ... }:

{

  age.secrets.base-net-postfix-smtp_sasl_password_maps = {
    file = "${secrets}/secrets/base/net/postfix/smtp_sasl_password_maps.age";
    path = "/var/lib/postfix/secret/smtp_sasl_password_maps";
    symlink = false;
    owner = "root";
    group = "postfix";
    mode  = "0440";
  };

  services.postfix = {
    enable = true;
    hostname = config.quyo.net.fqdn;
    rootAlias = "johm@quyo.de";

    extraConfig = ''
      relayhost = [mx.quyo.net]:587
      smtp_tls_security_level = encrypt
      smtp_sasl_auth_enable = yes
      smtp_sasl_password_maps = texthash:${config.age.secrets.base-net-postfix-smtp_sasl_password_maps.path}
      smtp_sasl_security_options = noanonymous
    '';
  };

}
