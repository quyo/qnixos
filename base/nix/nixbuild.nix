{ config, lib, pkgs, secrets, ... }:

{

  age.secrets.base-nix-nixbuild-ssh_shared_ed25519_key = {
    file = "${secrets}/secrets/base/nix/nixbuild/ssh_shared_ed25519_key.age";
    owner = "root";
    group = "root";
    mode  = "0400";
  };

  nix = {
    distributedBuilds = true;
    settings = {
      builders-use-substitutes = true;
      fallback = true;
      keep-going = true;
    };
  };

  nix.buildMachines = 
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

        sshKey = config.age.secrets.base-nix-nixbuild-ssh_shared_ed25519_key.path;
      };
    in
      builtins.map (system: nixbuildNet // { inherit system; }) systems;

  programs.ssh.knownHosts."eu.nixbuild.net".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIQCZc54poJ8vqawd8TraNryQeJnvH1eLpIDgbiqymM";
  programs.ssh.extraConfig = lib.mkBefore ''
    Host eu.nixbuild.net
      ServerAliveInterval 60
      IPQoS throughput
      PubkeyAcceptedKeyTypes ssh-ed25519
  '';

}
