# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, basePackages, baseServices, parameters, ... }:

let
  baseMachineTypePackages = with pkgs; [
    zenith
  ] ++ basePackages;

  baseMachineTypeServices = lib.recursiveUpdate baseServices {
    openssh.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # List services that you want to enable:
    flatpak.enable = true;
    fwupd.enable = true;
    printing.enable = true; # Enable CUPS to print documents
  }; 

in {
  imports =
    [
      (../desktop-env.nix)
      (../tmux.nix)

      # Machine specific config
      (
        import (../machines + "/${parameters.machine}.nix") {
          inherit lib;
          inherit config;
          inherit pkgs;
          inherit baseMachineTypePackages;
          inherit baseMachineTypeServices;
          # inherit parameters;
        }
      )
    ];

  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true; # added for pipewire

  sound.enable = true;

  users.users = {
    guest = {
      description = "guest";
      hashedPassword = "$6$rounds=1000$jpMpD5UmWhlVZyXN$wKOvA4n/6nTQpAxoA3SctqpcsmJ5eQuI0CgOPK3/83Tx27ZM9d4mrKZgoCctXTB5wixLaiv8XQUg0XfNw9Haj1";
      isNormalUser = true;
      shell = "/run/current-system/sw/bin/bash --restricted";
      useDefaultShell = false;
    };
    ceeser = {
      description = "ceeser";
      extraGroups = [ "networkmanager" "wheel" ];
      isNormalUser = true;
      packages = with pkgs; [
        ## general apps
        alacritty
        bitwarden
        pandoc
        tmuxinator

        ## development
        diff-so-fancy
        #dive # look into docker image layers
        #podman-tui # status of containers in the terminal
        #podman-compose # start group of containers for dev
        #docker-compose # start group of containers for dev
      ];
    }; 
  };
}
