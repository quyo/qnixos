default:
    just cleanup
    just update
    just upgrade

all:
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
