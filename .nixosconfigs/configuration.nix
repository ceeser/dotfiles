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

  users.defaultUserShell = pkgs.fish;
}
