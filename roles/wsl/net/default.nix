{ config, lib, pkgs, inputs, system, qlib, ... }:

{

  imports = qlib.scanPaths ./.;

}
