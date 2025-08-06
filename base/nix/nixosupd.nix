{ config, lib, pkgs, ... }:

{

  # Does not remove garbage collector roots, such as old system configurations.
  #nix.gc.automatic = true;
  #nix.gc.dates = "02:15";

  systemd.timers.nixosupd = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      RandomizedDelaySec = "3600";
      Persistent = false;
    };
  };

  systemd.services.nixosupd = {
    serviceConfig = {
      Type = "oneshot";
    };
    script = ''
      set -euo pipefail
      IFS=$'\n\t'

      PATH=$PATH:${pkgs.nix}/bin
      PATH=$PATH:${pkgs.nixos-rebuild}/bin
      PATH=$PATH:${pkgs.git}/bin
      PATH=$PATH:${pkgs.openssh}/bin

      nix-collect-garbage --delete-older-than 90d

      nix flake update                   --flake /etc/nixos
      nixos-rebuild switch               --flake /etc/nixos

      nix flake metadata nixpkgs          >/dev/null
      nix flake metadata nixpkgs-unstable >/dev/null

      GIT_AUTHOR_NAME="NixOSupd service"  GIT_AUTHOR_EMAIL="nixosupd@${config.quyo.host.fqdn}" \
      GIT_COMMITTER_NAME=$GIT_AUTHOR_NAME GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL                \
      git -C /etc/nixos commit -a -m "v$(date +%Y.%m.%d)-00"
    '';
  };

}
