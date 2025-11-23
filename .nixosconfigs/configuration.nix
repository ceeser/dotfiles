# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, ... }:

let
  ceeserMachineParams = import ./parameters.nix;

in {
  imports =
    [
      (/etc/nixos/hardware-configuration.nix)

      # base programs and services
      (./programs/fish.nix)
      (./programs/git.nix)
      (./programs/neovim.nix)
      (./services/tailscale.nix)

      # Machine Type specific config
      (./machines + "/${ceeserMachineParams.machineType}.nix")
    ];
  
  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    generic-extlinux-compatible.configurationLimit = 10;
  };

  documentation.nixos.enable = false; # turn off documentation

  environment.systemPackages = with pkgs; [
    bat
    dust
    eza
    starship
  ];
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
    nerd-fonts.fira-code
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

  services = {
    bpftune.enable = true;
  };

  users.defaultUserShell = pkgs.fish;
}
