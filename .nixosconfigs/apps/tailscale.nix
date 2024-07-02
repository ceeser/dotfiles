# Config for blocky

{ config, pkgs, ... }:

{
  services.tailscale = {
    enable = true;
  };
}
