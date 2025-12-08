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

      (./programs)
      (./services)

      # machine profiles
      (./machines/profiles)

      # Machine Type specific config
      (./machines + "/${ceeserMachineParams.machineType}s" + "/${ceeserMachineParams.machine}.nix")
    ];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    generic-extlinux-compatible.configurationLimit = 10;
  };

  ceeser.programs.fish.enable = true;
  ceeser.programs.git.enable = true;
  ceeser.programs.neovim.enable = true;
  ceeser.services.tailscale.enable = true;

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
      dates = "Sat *-*-* 04:00:00";
      options = "--delete-older-than 30d";
      randomizedDelaySec = "30min";
    };
    optimise = {
      automatic = true;
      dates = "Sat *-*-* 05:00:00";
      randomizedDelaySec = "30min";
    };
  };

  security = {
    rtkit.enable = true;
    sudo.execWheelOnly = true;
  };

  services = {
    bpftune.enable = true;
  };
}
