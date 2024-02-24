# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, basePackages, baseServices, parameters, ... }:

let
  baseMachineTypePackages = with pkgs; [] ++ basePackages;

  baseMachineTypeServices = lib.recursiveUpdate baseServices {
    openssh = {
      enable = true;
      # require public key authentication for better security
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
      settings.PermitRootLogin = "no";
    };
  }; 

in {
  imports = [
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

  system.autoUpgrade = {
    allowReboot = true;
    dates = "03:00";
    enable = true;
    flags = [
      "-I"
      "nixos-config=/home/ceeser/.nixosconfigs/configuration.nix"
    ];
    randomizedDelaySec = "45min";
  };

  users.users = {
    ceeser = {
      description = "just a regular account";
      extraGroups = [ "networkmanager" "wheel" ];
      initialHashedPassword = "$y$j9T$XaUpu.uuIDnfAYfzPxKqW.$LF6faepJC1x3F2akjhbv0fUkl314I7E3XmVekKL7TBA";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBADbQB9eZMIYo0l+CGxMnqNuWjCVqUhEKFOpWpJG0OqNkiqvozTcSYOu8MggCjDOFRzxn4rnN3Tyzb/gtXZREBTCFAF8ZBymZ4ZJYfFZn0C5vqI2szGrHRbhcu/YMo6aJwxbkQFZ2leXkyCKYCXuFYTtNCu1MxBw3iDn2MlGjK2FH0m3dA== ceeser"
      ];
      packages = with pkgs; [
        diff-so-fancy
      ];
    }; 
  };

  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      portainer-agent = {
        autoStart = true;
        extraOptions = [ "--privileged" ];
        image = "portainer/agent";
        ports = [
          "0.0.0.0:9001:9001"
        ];
        volumes = [ "/run/podman/podman.sock:/var/run/docker.sock:Z" ];
      };
    };
  };
}
