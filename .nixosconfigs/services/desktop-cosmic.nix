# Config for cosmic

{ config, pkgs, ... }:

{
  imports = [];

  services = {
    displayManager.cosmic-greeter.enable = true;
    desktopManager.cosmic.enable = true;
  };
}
