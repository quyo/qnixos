{ config, lib, pkgs, ... }:

{

  nix.settings = {
    auto-optimise-store = true;
    builders-use-substitutes = true;
    experimental-features = [ "nix-command" "flakes" ];
    require-sigs = true;
    sandbox = "relaxed";
    trusted-users = [ "johm" ];

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

}
