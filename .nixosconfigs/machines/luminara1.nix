{ lib, config, pkgs, baseMachineTypePackages, baseMachineTypeServices }:

{
  #imports = [];
  #boot = {};

  environment.systemPackages = with pkgs; [] ++ baseMachineTypePackages;

  networking.hostName = "luminara1"; # Define your hostname.
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [ 443 ];

  services = lib.recursiveUpdate baseMachineTypeServices {
    resolved.enable = false;
    caddy = {
      enable = true;
      virtualHosts."photos.ceeser.com".extraConfig = ''
        reverse_proxy 100.94.100.96:2342
      '';
    };
  };

  time.timeZone = "America/Toronto";
}
