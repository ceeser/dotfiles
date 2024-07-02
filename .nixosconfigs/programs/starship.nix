# Config for neovim

{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ./starship.toml;
  };
}
