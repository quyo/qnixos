{ inputs, system }:

let
  getEnv = name: value:
    let
      x = builtins.getEnv name;
    in
      if x != ""
      then x
      else (throw "${name} not set; export ${name}=${value}");

  hostname = getEnv "QNIXOS_HOSTNAME" "proxmox-lxc";

  nixosGenerated =
    let
      nixos-generators = inputs.nixos-generators;
      extendSpecialArgs = inputs.self.outputs.extendSpecialArgs;
      nixosModules = inputs.self.outputs.nixosModules;

      generated = nixos-generators.nixosGenerate {
        inherit system;
        format = "proxmox-lxc";

        specialArgs = extendSpecialArgs { inherit system hostname; };

        modules = [
          nixosModules.${hostname}
        ];
      };
    in
      generated.overrideAttrs (_: {
        preferLocalBuild = true;
        allowSubstitutes = false;
      });

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

      AGE_IDENTITY = getEnv "AGE_IDENTITY" "/path/to/key";
    }
    ''
      set -Eeuo pipefail
      IFS=$'\n\t'

      test -r "$AGE_IDENTITY" || { echo "AGE_IDENTITY not readable: $AGE_IDENTITY" >&2; exit 1; }

      WORK="$(mktemp -d)"; trap 'rm -rf "$WORK"' EXIT INT TERM
      TMPOUT="$WORK/out"

      fakeroot -- ${pkgs.bash}/bin/bash "${secrets}/scripts/inject-hostkey-into-tar.sh" \
        "${nixosTarballIn}" \
        "${secrets}/secrets/hosts/${hostname}/ssh/ssh_host_ed25519_key.age" \
        "$TMPOUT"

      install -m 0444 -T "$TMPOUT" "$out"
    ''
