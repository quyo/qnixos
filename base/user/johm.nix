{ config, lib, pkgs, secrets, ... }:

{

  users.users.johm = {
    isNormalUser = true;
    description = "Markus John";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys =
      let
        userkey = host: builtins.readFile "${secrets}/secrets/hosts/${host}/ssh/ssh_johm_ed25519_key.pub";
      in
        map userkey [
          "de-adn-2tyd893"
          "nyx"
          "predator"
        ];
  };

}
