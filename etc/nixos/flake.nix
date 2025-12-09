{
  description = "qNixOS";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://quyo-public.cachix.org"
      "ssh://eu.nixbuild.net?priority=90"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "quyo-public.cachix.org-1:W83ifK7/6EvKU4Q2ZxvHRAkiIRzPeXYnp9LWHezs5U0="
      "nixbuild.net/quyo-1:TaAsUc6SBQnXhUQJM4s+1oQlTKa1e3M0u3Zqb36fbRc="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/release-25.11";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    qnixos.url = "github:quyo/qnixos";
    qnixos.inputs.nixpkgs.follows = "nixpkgs";
    qnixos.inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
    qnixos.inputs.nixos-wsl.follows = "nixos-wsl";
  };

  outputs = inputs@{ self, nixpkgs, qnixos, ... }:
    let
      hostname = "foobar";
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {

        inherit system;

        specialArgs = qnixos.extendSpecialArgs { inherit inputs system hostname; };

        modules = [
          qnixos.nixosModules.${hostname}
        ];

      };
    };
}
