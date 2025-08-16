{ config, lib, pkgs, ... }:

{

  programs.ssh.knownHosts = {

    github-ed25519 = {
      hostNames = [ "github.com" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
    };
    github-rsa = {
      hostNames = [ "github.com" ];
      publicKey = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCj7ndNxQowgcQnjshcLrqPEiiphnt+VTTvDP6mHBL9j1aNUkY4Ue1gvwnGLVlOhGeYrnZaMgRK6+PKCUXaDbC7qtbW8gIkhL7aGCsOr/C56SJMy/BCZfxd1nWzAOxSDPgVsmerOBYfNqltV9/hWCqBywINIR+5d";
    };
    github-nistp256 = {
      hostNames = [ "github.com" ];
      publicKey = "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=";
    };

    "do-fra1-docker.tailaccaf.ts.net".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFmcFXs8eAZK23MJFjjp5eITdstycXqgf7/ZWRWXxkm+";
    "do-fra1-mx.tailaccaf.ts.net".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFY0LHoXOLvP6CFBcHj2fUDop5CntR4L5fAiAddgL9Wq";
    "do-fra1-ns.tailaccaf.ts.net".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJzEzr0+6WN7zIiEIfqTUGak9yFFqxnHvg9twu6yGBas";
    "do-fra1-matrix.tailaccaf.ts.net".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIExxhbOeWTYuitxLVFG/opw4HUPAV6fcN53o7rQQZQvy";

    "ka-core.tailaccaf.ts.net".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPMBhiy68JIS9v03XIkJpioK8zrfQVnQwHCidCjZoOlX";
    "ka-sky-harbor.tailaccaf.ts.net".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGr2mJh30G/UhroOTkGacUSatmbTUEmW+eAnujfE7ajA";

    ka-sky-nyx = {
      hostNames = [ "ka-sky-nyx.tailaccaf.ts.net" "nyx.sky.quyo.net" "sky.quyo.net" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGfU5fWGMhuf6y1re7qhnAUE11o+SiqIyTbtNqbvR+w/";
    };

    "192.168.72.102".publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINTmPTBd7Xqwmy5xes33F3WSqBY5SAA58C9euWr07QVq";

  };

  programs.ssh.extraConfig = ''

    Host docker
      User root
      HostName do-fra1-docker.tailaccaf.ts.net

    Host mx
      User root
      HostName do-fra1-mx.tailaccaf.ts.net

    Host ns
      User root
      HostName do-fra1-ns.tailaccaf.ts.net

    Host matrix
      User root
      HostName do-fra1-matrix.tailaccaf.ts.net


    Host core
      User pi
      HostName ka-core.tailaccaf.ts.net

    Host nyx
      User johm
      HostName ka-sky-nyx.tailaccaf.ts.net

    Host harbor
      User johm
      HostName ka-sky-harbor.tailaccaf.ts.net

    Host bigben
      User johm
      HostName 192.168.72.102

  '';

}
