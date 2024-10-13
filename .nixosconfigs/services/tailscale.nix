# Config for tailscale

{ config, pkgs, ... }:

{
  services.tailscale = {
    enable = true;
    permitCertUid = "caddy";
  };
}
