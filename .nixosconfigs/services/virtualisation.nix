# Config for neovim

{ config, pkgs, ... }:

{
  imports = [];

  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
}
