# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, ... }:

let
  parameters = import ./parameters.nix;

  basePackages = with pkgs; [
    bat
    du-dust
    eza
    fish
    git
    starship
    tailscale
  ];

  baseServices = {
    tailscale.enable = true;
  };

in {
  imports =
    [
      (/etc/nixos/hardware-configuration.nix)
      # Machine Type specific config
      (
        import (./machines + "/${parameters.machineType}.nix") {
          inherit lib;
          inherit config;
          inherit pkgs;
          inherit basePackages;
          inherit baseServices;
          inherit parameters;
        }
      )
      (./fish.nix)
      (./git.nix)
      (./neovim.nix)
      (./no-defaults.nix)
    ];

  
  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  documentation.nixos.enable = false;

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    font-awesome
  ];

  i18n.defaultLocale = "en_CA.UTF-8"; # Select internationalisation properties.

  networking = {
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscaled" ];
    };
    networkmanager.enable = true; # Enable networking
  };

  nixpkgs.config.allowUnfree = true; # Allow unfree packages

  nix = {
    settings.allowed-users = [ "@wheel" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  security = {
    rtkit.enable = true;
    sudo.execWheelOnly = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.fish;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
