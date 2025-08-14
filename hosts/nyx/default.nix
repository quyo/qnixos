{ config, lib, pkgs, inputs, system, qlib, ... }:

{

  imports = qlib.scanPaths ./.
    ++
    map qlib.relativeToRoot
    [
      "roles/desktop"
      "parts/docker"
      "parts/no-ip"
      "parts/qemu-guest"
    ];

}
