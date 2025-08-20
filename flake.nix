{
  description = "qNixOS modules";

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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/release-25.05";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    # optionally choose not to download darwin deps (saves some resources on Linux)
    agenix.inputs.darwin.follows = "";

    qnixpkgs.url = "github:quyo/qnixpkgs";
    qnixpkgs.inputs.nixpkgs-stable.follows = "nixpkgs";
    qnixpkgs.inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
    qnixpkgs.inputs.qnixpkgs.follows = "qnixpkgs";

    # qnixos-secrets.url = "git+ssh://git@github.com/quyo/qnixos-secrets";  # SSH via Key
    qnixos-secrets.url   = "github:quyo/qnixos-secrets";                    # HTTPS via Token (PAT)
    qnixos-secrets.flake = false;
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    {
      extendSpecialArgs = import ./specialArgs.nix { inherit inputs; };
      nixosModules = import ./hosts { lib = nixpkgs.lib; };
      packages = import ./packages.nix { inherit inputs; };
    };
}
