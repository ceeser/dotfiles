{ lib, config, pkgs, ... }:

{
  #boot = {};

  imports = [
    <nixos-hardware/framework/16-inch/7040-amd>
    (../../services/virtualisation.nix)
  ];

  environment.systemPackages = with pkgs; [
    #ansel
    #handbrake
    #ollama
    gimp3
    restic
  ];

  hardware.keyboard.uhk.enable = false;
  hardware.keyboard.qmk.enable = false;

  networking.hostName = "darnala";

  services = {
    fprintd.enable = true;
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
      ceeserdocumentsremote = {
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
        repository = "rest:http://aayla1.bun-buri.ts.net:8000/ceeserdocuments";
        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
        };
        user = "ceeser";
      };
    };
    syncthing = {
      enable = true;
      user = "ceeser";
      dataDir = "/home/ceeser";    # Default folder for new synced folders
      configDir = "/home/ceeser/.config/syncthing";   # Folder for Syncthing's settings and keys
      overrideDevices = true;     # overrides any devices added or deleted through the WebUI
      overrideFolders = true;     # overrides any folders added or deleted through the WebUI
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
