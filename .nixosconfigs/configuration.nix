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
    starship
  ];

  baseServices = {};

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
      (./programs/fish.nix)
      (./programs/git.nix)
      (./programs/neovim.nix)
      (./services/tailscale.nix)
    ];

  
  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    generic-extlinux-compatible.configurationLimit = 10;
  };

  documentation.nixos.enable = false; # turn off documentation

  environment.defaultPackages = lib.mkForce []; # no default packages
  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";

    # Not officially in the specification
    XDG_BIN_HOME    = "$HOME/.local/bin";
    PATH = [ 
      "${XDG_BIN_HOME}"
    ];
  };


  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    font-awesome
  ];

  i18n.defaultLocale = "en_CA.UTF-8"; # Select internationalisation properties.

  networking = {
    firewall.enable = true;
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
