{ lib, config, pkgs, baseMachineTypePackages, baseMachineTypeServices }:

{
  imports = [
    (../../apps/blocky.nix)
  ];

  environment.systemPackages = with pkgs; [] ++ baseMachineTypePackages;

  networking.hostName = "luminara1"; # Define your hostname.
  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [ 443 ];

  services = lib.recursiveUpdate baseMachineTypeServices {
    caddy = {
      enable = true;
      virtualHosts."photos.ceeser.com".extraConfig = ''
        reverse_proxy 100.94.100.96:2342
      '';
    };
  };

  time.timeZone = "America/Toronto";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
