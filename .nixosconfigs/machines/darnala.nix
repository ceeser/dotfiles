{ lib, config, pkgs, baseMachineTypePackages, baseMachineTypeServices }:

{
  #imports = [];
  #boot = {};

  environment.systemPackages = with pkgs; [
  ] ++ baseMachineTypePackages;

  networking.hostName = "darnala"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  programs.steam.enable = true;

  services = lib.recursiveUpdate baseMachineTypeServices {};

  time.timeZone = "America/Toronto";
}
