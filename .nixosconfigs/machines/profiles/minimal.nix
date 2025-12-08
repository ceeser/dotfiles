# This module defines a small NixOS configuration.  It does not
# contain any graphical stuff.
# Taken from https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/profiles/minimal.nix

{ lib, config, ... }:

let
  inherit (lib) mkDefault;
in {
  options.ceeser.profiles.minimal = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Sets a machine up with a minimal configuration
      '';
    };
  };

  config = lib.mkIf config.ceeser.profiles.minimal.enable {
    documentation = {
      enable = mkDefault false;
      doc.enable = mkDefault false;
      info.enable = mkDefault false;
      man.enable = mkDefault false;
      nixos.enable = mkDefault false;
    };

    environment = {
      # Perl is a default package.
      defaultPackages = mkDefault [ ];
      stub-ld.enable = mkDefault false;
    };

    programs = {
      command-not-found.enable = mkDefault false;
      fish.generateCompletions = mkDefault false;
    };

    services = {
      logrotate.enable = mkDefault false;
      udisks2.enable = mkDefault false;
    };

    xdg = {
      autostart.enable = mkDefault false;
      icons.enable = mkDefault false;
      mime.enable = mkDefault false;
      sounds.enable = mkDefault false;
    };
  };
}
