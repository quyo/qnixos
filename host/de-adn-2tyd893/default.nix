{ config, lib, pkgs, inputs, system, qlib, ... }:

{

  imports = qlib.scanPaths ./.
    ++
    map qlib.relativeToRoot
    [
      "role/wsl"
    ];

}
