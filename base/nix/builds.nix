{ config, lib, pkgs, ... }:

let
  systems = [
    "x86_64-linux"
    "i686-linux"
    "aarch64-linux"
    "armv7l-linux"
  ];

  nixbuildNet = {
    hostName = "eu.nixbuild.net";
    protocol = "ssh-ng";
    maxJobs = 100;
    supportedFeatures = [ "big-parallel" "benchmark" ];

    sshKey = "${config.users.users.root.home}/.ssh/id_ed25519";
  };
in
{

  nix = {
    distributedBuilds = true;
    settings = {
      builders-use-substitutes = true;
      fallback = true;
      keep-going = true;
    };
  };

  nix.buildMachines = builtins.map (system: nixbuildNet // { inherit system; }) systems;

  programs.ssh.knownHosts."eu.nixbuild.net".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIQCZc54poJ8vqawd8TraNryQeJnvH1eLpIDgbiqymM";
  programs.ssh.extraConfig = lib.mkBefore ''
    Host eu.nixbuild.net
      ServerAliveInterval 60
      IPQoS throughput
      PubkeyAcceptedKeyTypes ssh-ed25519
  '';

}
