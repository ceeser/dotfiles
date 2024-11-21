{ lib, config, pkgs, baseMachineTypePackages, baseMachineTypeServices }:

{
  boot.loader.grub = {
     efiSupport = true;
     efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
     device = "nodev";
  };

  environment.systemPackages = with pkgs; [] ++ baseMachineTypePackages;
  networking.hostName = "aayla1"; # Define your hostname.

  services = lib.recursiveUpdate baseMachineTypeServices {
    restic.server.enable = true;
  };

  time.timeZone = "America/Toronto";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
