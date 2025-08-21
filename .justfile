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


lxc:
    just proxmox-lxc-template

proxmox-lxc-template:
    nix build --builders '' .#proxmox-lxc-template
    cp -f --update=all ./result/tarball/*.tar.xz .
    rm -rf ./result
    chmod 644 *.tar.xz
