{ lib, config, pkgs, baseMachineTypePackages, baseMachineTypeServices }:

{
  #boot = {};

  imports = [
    (../virtualisation.nix)
    # (../containers.nix)
  ];

  environment.systemPackages = with pkgs; [
    restic
  ] ++ baseMachineTypePackages;

  networking.hostName = "darnala"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  services = lib.recursiveUpdate baseMachineTypeServices {
    restic.backups = {
      ceeserdocuments = {
        initialize = true;
        passwordFile = "/home/ceeser/.restic/.passwords/.ceeser";
        paths = [
          "/home/ceeser/Documents"
        ];
        pruneOpts = [
          "--keep-daily 7"
          "--keep-weekly 5"
          "--keep-monthly 12"
          "--keep-yearly 15"
        ];
        repository = "/home/ceeser/data/backups/ceeser/documents";
        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
        };
        user = "ceeser";
      };
    };
    power-profiles-daemon.enable = true;
  };

  time.timeZone = "America/Toronto";
}
