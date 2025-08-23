{ config, lib, pkgs, ... }:

let
  defaultProfile = pkgs.writeText "default-profile" ''
    if [ -n "''${BASH_VERSION-}" ]; then
      case $- in
        *i*) [ -r "$HOME/.bashrc" ] && . "$HOME/.bashrc" ;;
      esac
    fi

    . /run/current-system/sw/share/dotfiles/.profile
  '';

  defaultBashrc = pkgs.writeText "default-bashrc" ''
    source /run/current-system/sw/share/dotfiles/.bashrc
  '';
in
{

  system.activationScripts.seedShellDefaults = {
    deps = [ "etc" "users" ];

    text = ''
      set -Eeuo pipefail
      IFS=$'\n\t'

      seed() {
        local USER="$1" GROUP="$2" HOME="$3" FILE="$4" SRC="$5"
        local TARGET="$HOME/$FILE"

        if [ ! -e "$TARGET" ]; then
          install -m 0644 -o $USER -g $GROUP "$SRC" "$TARGET"
          echo "Seeded $TARGET"
        fi
      }

      seed root root /root .profile "${defaultProfile}"
      seed root root /root .bashrc  "${defaultBashrc}"

      if getent passwd johm >/dev/null; then
        HOME="$(getent passwd johm | cut -d: -f6)"
        seed johm users "$HOME" .profile "${defaultProfile}"
        seed johm users "$HOME" .bashrc  "${defaultBashrc}"
      fi
    '';
  };

}
