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
      [
        # OBSOLETE
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDJbNZ7WPukcyJs8KSPn8/LGfk4knwicscIBIhKAuEh6 johnm@de-adn-2tyd893"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPbe3UzNIWAtDSZD0IBGBldV6BbHo0LGPVLDC/PXPaMR johm@nyx"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMkccByEYMQ2vXmSkU9x0WJpnLDseu8wFSKiPQCjH/Kt johm@predator"
      ] ++ map userkey [
        "de-adn-2tyd893"
        "nyx"
        "predator"
      ];
  };

}
