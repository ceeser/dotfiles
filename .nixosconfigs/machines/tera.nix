{ lib, config, pkgs, baseMachineTypePackages, baseMachineTypeServices }:

{
  #imports = [];
  #boot = {};

  environment.systemPackages = with pkgs; [
  ] ++ baseMachineTypePackages;

  networking.hostName = "tera"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  services = lib.recursiveUpdate baseMachineTypeServices {
    power-profiles-daemon.enable = false;
    tlp.enable = true;
  };

  time.timeZone = "America/Toronto";
}
