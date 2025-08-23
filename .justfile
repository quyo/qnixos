set shell := ["bash", "-euo", "pipefail", "-c"]


default:
    just edit
    just cleanup
    just update
    just upgrade

all:
    just edit
    just cleanup
    just update-all
    just upgrade


update:
    sudo nix flake update qnixos --flake /etc/nixos

update-all:
    sudo nix flake update --flake /etc/nixos

upgrade:
    sudo nixos-rebuild switch --flake /etc/nixos

cleanup:
    sudo nix-collect-garbage --delete-older-than 7d

edit:
    sudo $EDITOR /etc/nixos/flake.nix


lxc hostname="proxmox-lxc" age_identity="/home/johm/.ssh/id_ed25519":
    just build-proxmox-lxc-template {{hostname}} {{age_identity}}
    just serve-proxmox-lxc-template

build-proxmox-lxc-template hostname age_identity:
    QNIXOS_HOSTNAME={{hostname}} AGE_IDENTITY="{{age_identity}}" ../qnixos-secrets/scripts/build-with-age-identity.sh

serve-proxmox-lxc-template:
    nix run nixpkgs#python3 -- -m http.server 8080 --bind $(ip route get 1.1.1.1 | awk '{print $7; exit}')
