{ lib, config, pkgs, baseMachineTypePackages, baseMachineTypeServices }:

{
  imports = [
    (../blocky.nix)
  ];

  environment.systemPackages = with pkgs; [] ++ baseMachineTypePackages;

  networking.hostName = "kiadi1"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  services = lib.recursiveUpdate baseMachineTypeServices {
    resolved.enable = false;
  };

  time.timeZone = "America/Toronto";
}
