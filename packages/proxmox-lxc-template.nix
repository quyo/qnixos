{ inputs, system }:

let
  nixosGenerated =
    let
      nixos-generators = inputs.nixos-generators;
      extendSpecialArgs = inputs.self.outputs.extendSpecialArgs;
      nixosModules = inputs.self.outputs.nixosModules;
    in
      nixos-generators.nixosGenerate {
        inherit system;
        format = "proxmox-lxc";

        specialArgs = extendSpecialArgs { inherit system; hostname = "proxmox-lxc"; };

        modules = [
          nixosModules.proxmox-lxc
        ];
      };

  nixosDir = nixosGenerated + "/tarball";

  nixosFiles = builtins.filter
    (n: builtins.match ".*\\.tar\\..*$" n != null)
    (builtins.attrNames (builtins.readDir nixosDir));

  nixosTarballIn =
    if builtins.length nixosFiles == 1
    then nixosDir + "/" + builtins.head nixosFiles
    else throw "Expected exactly one *.tar.* in ${toString nixosDir}, found: ${toString nixosFiles}";

  nixosTarballOut =
    let
      m = builtins.match ''^(.*)\.tar\.(xz|zst|gz|bz2)$'' (builtins.baseNameOf nixosTarballIn);
      base = builtins.elemAt m 0;
      ext  = builtins.elemAt m 1;
    in
      "${base}-with-hostkey.tar.${ext}";

  pkgs = import inputs.nixpkgs { inherit system; };
  secrets = inputs.qnixos-secrets;
in
  pkgs.runCommand nixosTarballOut
    {
      passthru.outName = nixosTarballOut;

      nativeBuildInputs = [
        pkgs.age
        pkgs.fakeroot
        pkgs.gnutar
        pkgs.openssh
        pkgs.xz
      ];

      AGE_IDENTITY =
        let
          p = builtins.getEnv "AGE_IDENTITY";
        in
          if p != ""
          then p
          else (throw "AGE_IDENTITY not set; export AGE_IDENTITY=/path/to/key");
    }
    ''
      set -Eeuo pipefail
      IFS=$'\n\t'

      test -r "$AGE_IDENTITY" || { echo "AGE_IDENTITY not readable: $AGE_IDENTITY" >&2; exit 1; }

      tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT INT TERM
      tmpout="$tmp/out"

      fakeroot -- ${pkgs.bash}/bin/bash "${secrets}/scripts/inject-hostkey-into-tar.sh" \
        "${nixosTarballIn}" \
        "${secrets}/secrets/hosts/proxmox-lxc/ssh/ssh_host_ed25519_key.age" \
        "$tmpout"

      install -m 0444 -T "$tmpout" "$out"
    ''
