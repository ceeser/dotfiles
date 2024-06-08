{ lib, config, pkgs, baseMachineTypePackages, baseMachineTypeServices }:

{
  imports = [
    (../../blocky.nix)
  ];

  environment.systemPackages = with pkgs; [] ++ baseMachineTypePackages;

  networking.hostName = "kiadi1"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  services = lib.recursiveUpdate baseMachineTypeServices {};

  time.timeZone = "America/Toronto";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
