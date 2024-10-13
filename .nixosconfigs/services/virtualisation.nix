# Config for desktop hypervisor

{ config, pkgs, ... }:

{
  imports = [];

  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
}
