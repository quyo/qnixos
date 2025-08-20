{ config, lib, pkgs, qlib, ... }:

{

  system.activationScripts.seedEtcNixos =
    let
      seed = qlib.relativeToRoot "etc/nixos";
    in
    {
      deps = [ "etc" ];
      text = ''
        set -euo pipefail
        IFS=$'\n\t'

        if [ ! -e /etc/nixos/.seeded ]; then
          mkdir -p /etc/nixos
          ${pkgs.coreutils}/bin/cp -aT ${seed} /etc/nixos
          ${pkgs.coreutils}/bin/touch /etc/nixos/.seeded
          ${pkgs.git}/bin/git -C /etc/nixos init
        fi
      '';
    };

}
