{ lib, config, pkgs, baseMachineTypePackages, baseMachineTypeServices }:

{
  #imports = [];
  #boot = {};

  environment.systemPackages = with pkgs; [] ++ baseMachineTypePackages;

  networking.hostName = "aayla3"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  services = lib.recursiveUpdate baseMachineTypeServices {
    tailscale.permitCertUid = "caddy";
    caddy = {
      enable = true;
      virtualHosts."aayla3.bun-buri.ts.net".extraConfig = ''
        handle_path /portainer/* {
          rewrite * {path}
          reverse_proxy localhost:9000
        }
        reverse_proxy /calibre* localhost:8083 {
          header_up X-Scheme https
          header_up X-Script-Name /calibre
        }
        reverse_proxy /paperless* localhost:8084
        reverse_proxy /vaultwarden* localhost:8085
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
